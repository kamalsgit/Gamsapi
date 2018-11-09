require 'gamsapi'

#configuration stuffs
mainObj=Gamsapi.indexMethod()
mainObj.publicKey = "9776183a1726e216c245ce5e6c3c8c86"
mainObj.publicToken = "dc89654c33ad976960aba71a92967b9e3aee92de41beed0392fb007b141af8a6"    
mainObj.acctName = "kamalshekaran"
mainObj.boardID = "5be05576331ed41d662e6dbe"        
mainObj.dbHost = "localhost"
mainObj.dbUsername = "postgres"
mainObj.dbPassword = "inxys@123"
mainObj.dbName = "custom"
mainObj.dbPort = "5432" 

#invoking methods and assigning as accessor 
mainObj.boardProfileName=mainObj.getAccountName       
mainObj.boardName=mainObj.getBoardName 
mainObj.cardList=mainObj.getCards   	 
mainObj.saveCards 	
mainObj.writeGamsFile 






