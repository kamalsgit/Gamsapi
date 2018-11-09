require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require 'pg'
require 'date'

class Gamsapi::Trello

    configObjects = [:publicKey,:publicToken,:boardID,:dbHost,:dbUsername,:dbPassword,:dbName,:dbPort,:dbObject,:acctName,:boardProfileName,:cardList,:boardName]
    attr_accessor *configObjects    

    def initialize(publicKey='test',publicToken='',boardID='',acctName='',dbHost='',dbUsername='',dbPassword='',dbName='',dbPort='')        
        @publicKey = publicKey
        @publicToken = publicToken
        @boardID = boardID
        @acctName = acctName        
        @dbHost = dbHost
        @dbUsername = dbUsername
        @dbPassword = dbPassword
        @dbName = dbName  
        @dbPort = dbPort  
        #@dbObject = dbConnect()
    end
    
    def getAccountName          
		nameObject=''
        begin	
            url = URI("https://api.trello.com/1/members/"+@acctName+"?key="+@publicKey+"&token="+@publicToken)
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE
            request = Net::HTTP::Get.new(url)
            response = http.request(request)
            boardDetails = JSON.parse(response.read_body)    			
            nameObject=boardDetails['fullName']		
        rescue => e
			abort("========= Please fix the below errors =============\n\r\n\r"+e.message)						
		end
		return nameObject
    end
	
	def getBoardName
		responseObj=''
		begin	
			url = URI("https://api.trello.com/1/boards/"+@boardID+"?key="+@publicKey+"&token="+@publicToken)
			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			request = Net::HTTP::Get.new(url)
			response = http.request(request)        
			responseObj=JSON.parse(response.read_body) 	
			responseObj=responseObj['name'];
		rescue => e
			abort("========= Please fix the below errors =============\n\r\n\r"+e.message)						
		end
		return responseObj
    end
        
    def getCards
		responseObj=''
		begin	
			url = URI("https://api.trello.com/1/boards/"+@boardID+"/cards?fields=id,name&key="+@publicKey+"&token="+@publicToken)
			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = true
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			request = Net::HTTP::Get.new(url)
			response = http.request(request)        
			responseObj=JSON.parse(response.read_body) 				
		rescue => e
			abort("========= Please fix the below errors =============\n\r\n\r"+e.message)						
		end
		return responseObj
    end

    def saveCards	
		begin					
			if @cardList.nil?
				abort("========= No cards or tasks available =============")	
			end
			connObj = self.dbConnect  			
			connObj.exec "delete from task_list where bid='"+@boardID+"'"				
			@cardList.each do |collection|		
				getTitle=self.getTitle collection['name'],'title'
				getEstimated=self.getTitle collection['name'],'estimated'				
				getSpent=self.getTitle collection['name'],'spent'				
				getCurrentTask=self.getTitle collection['name'],'currentTask'
				getDependTask=self.getTitle collection['name'],'dependTask'				
				connObj.exec "insert into task_list(title,estimated_hour,spent_hour,current_card_id,depend_task_id,bid) values('"+getTitle+"','"+getEstimated+"','"+getSpent+"','"+getCurrentTask+"','"+getDependTask+"','"+@boardID+"')" 
			end			
		rescue => e
			abort("========= Please fix the below errors =============\n\r\n\r"+e.message)						
		end
    end
    
    def dbConnect
		con='';
        begin
			con = PG.connect :dbname => @dbName, :user => @dbUsername, :password => @dbPassword			
		rescue PG::Error => e
			abort("========= Please fix the below errors =============\n\r\n\r"+e.message)						
		end
		return con		
    end
	
	def getTitle(name,colName)
		title=''
		estimated=''
		spent=''
		currentTask=''
		dependTask=''
		begin
			extractTitle=name.split('-')			
			if (name.index("(")!=nil && name.index(")")!=nil) 
				estimated=name[name.index("(")+1..name.index(")")-1].lstrip.rstrip     
			end			
			if (name.index("[")!=nil && name.index("]")!=nil) 
				spent=name[name.index("[")+1..name.index("]")-1].lstrip.rstrip    
			end			
			tempTitle=name;
			if (estimated!=nil) 
				tempTitle=tempTitle.gsub('('+estimated+')', '').lstrip.rstrip   
			end
			if (spent!=nil) 
				tempTitle=tempTitle.gsub('['+spent+']', '').lstrip.rstrip   
			end	
			extractTitle=tempTitle.split('-')
			title=extractTitle[0]
			
			if (extractTitle[1].index("Card ")!=nil && extractTitle[1].index("DepCard")!=nil) 
				currentTask=extractTitle[1][extractTitle[1].index("Card ")+5..extractTitle[1].index("DepCard")-1].lstrip.rstrip    
			end			
			if (extractTitle[1].index("DepCard")!=nil) 
				dependTask=extractTitle[1][extractTitle[1].index("DepCard")+8..extractTitle[1].length-1].lstrip.rstrip    
			end
			
		rescue => e
			abort("========= Please fix the below errors =============\n\r\n\r"+e.message)						
		end		
		return eval(colName)
    end
    
    def writeGamsFile
		begin
			text = File.read(File.dirname(__FILE__)+"/default.inc")
			new_contents = text.gsub("[Emp]", '"'+@boardProfileName+'"') 
			new_contents = new_contents.gsub("[Project]", '"'+@boardName+'"')
			
			empProject=''
			empProjectHrs=''
			empProjectDepend=''
			connObj = self.dbConnect
			rs = connObj.exec "SELECT * FROM task_list where bid='"+@boardID+"'"
			rs.each do |row|
				#puts "%s %s %s" % [ row['id'], row['name'], row['price'] ]
				empProject = empProject+'"'+@boardName+'".'+'"'+row['current_card_id']+'".'+'"'+@boardProfileName+'"'
				empProject+="\n"
				empProjectHrs = empProjectHrs+'"'+@boardName+'".'+'"'+row['current_card_id']+'"='+'"'+row['estimated_hour'].lstrip.rstrip+'"'
				empProjectHrs+="\n"
				empProjectDepend = empProjectDepend+'"'+@boardName+'".'+'"'+row['current_card_id']+'".'+'"'+row['depend_task_id']+'"='+'"'+row['spent_hour'].lstrip.rstrip+'"'
				empProjectDepend+="\n"
			end	
			new_contents = new_contents.gsub("[projAssign]", empProject)
			new_contents = new_contents.gsub("[projAssignHrs]", empProjectHrs)
			new_contents = new_contents.gsub("[ProjDepend]", empProjectDepend)
			
			File.open("output.inc", "w") do |f|               
			  f.write(new_contents)   
			end
			
		rescue => e
			abort("========= Please fix the below errors =============\n\r\n\r"+e.message)						
		end        
    end
end