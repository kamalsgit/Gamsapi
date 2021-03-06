PGDMP         ,        	    
    v            custom    10.5    10.5     �
           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �
           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �
           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �
           1262    16394    custom    DATABASE     �   CREATE DATABASE custom WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE custom;
             postgres    false            �
           0    0    DATABASE custom    COMMENT     (   COMMENT ON DATABASE custom IS 'custom';
                  postgres    false    2808                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            �
           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            �
           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    16401 
   board_list    TABLE     j   CREATE TABLE public.board_list (
    lid text NOT NULL,
    lname text NOT NULL,
    bid text NOT NULL
);
    DROP TABLE public.board_list;
       public         postgres    false    3            �
           0    0    COLUMN board_list.lid    COMMENT     6   COMMENT ON COLUMN public.board_list.lid IS 'list id';
            public       postgres    false    197            �
           0    0    COLUMN board_list.lname    COMMENT     :   COMMENT ON COLUMN public.board_list.lname IS 'list name';
            public       postgres    false    197            �
           0    0    COLUMN board_list.bid    COMMENT     7   COMMENT ON COLUMN public.board_list.bid IS 'board id';
            public       postgres    false    197            �            1259    16395    boards    TABLE     F   CREATE TABLE public.boards (
    bname text,
    bid text NOT NULL
);
    DROP TABLE public.boards;
       public         postgres    false    3            �
           0    0    TABLE boards    COMMENT     J   COMMENT ON TABLE public.boards IS 'List of Board names or Project names';
            public       postgres    false    196                        0    0    COLUMN boards.bname    COMMENT     7   COMMENT ON COLUMN public.boards.bname IS 'Board name';
            public       postgres    false    196                       0    0    COLUMN boards.bid    COMMENT     3   COMMENT ON COLUMN public.boards.bid IS 'Board Id';
            public       postgres    false    196            �            1259    16407 	   task_list    TABLE     �   CREATE TABLE public.task_list (
    title text,
    current_card_id text,
    depend_task_id text,
    bid text,
    estimated_hour character(10),
    spent_hour character(10)
);
    DROP TABLE public.task_list;
       public         postgres    false    3                       0    0    TABLE task_list    COMMENT     7   COMMENT ON TABLE public.task_list IS 'Cards or Tasks';
            public       postgres    false    198                       0    0    COLUMN task_list.title    COMMENT     H   COMMENT ON COLUMN public.task_list.title IS 'card title or task title';
            public       postgres    false    198                       0    0     COLUMN task_list.current_card_id    COMMENT     I   COMMENT ON COLUMN public.task_list.current_card_id IS 'current card id';
            public       postgres    false    198                       0    0    COLUMN task_list.depend_task_id    COMMENT     F   COMMENT ON COLUMN public.task_list.depend_task_id IS 'priority task';
            public       postgres    false    198                       0    0    COLUMN task_list.bid    COMMENT     6   COMMENT ON COLUMN public.task_list.bid IS 'board id';
            public       postgres    false    198                       0    0    COLUMN task_list.estimated_hour    COMMENT     F   COMMENT ON COLUMN public.task_list.estimated_hour IS 'estimatedHour';
            public       postgres    false    198                       0    0    COLUMN task_list.spent_hour    COMMENT     >   COMMENT ON COLUMN public.task_list.spent_hour IS 'spentHour';
            public       postgres    false    198            �
          0    16401 
   board_list 
   TABLE DATA               5   COPY public.board_list (lid, lname, bid) FROM stdin;
    public       postgres    false    197   �       �
          0    16395    boards 
   TABLE DATA               ,   COPY public.boards (bname, bid) FROM stdin;
    public       postgres    false    196   �       �
          0    16407 	   task_list 
   TABLE DATA               l   COPY public.task_list (title, current_card_id, depend_task_id, bid, estimated_hour, spent_hour) FROM stdin;
    public       postgres    false    198   '       �
      x������ � �      �
   9   x�)J���W(�Wpw�Vp��4MJ50557366LM11L133J5KIJ����� e�      �
   	  x����N�0E��W�Ty�aM�@�@��ݱq�iqk2���cQ����b��]�Ɠ�3l4*E�"�X�m/P�{MG���t��BT��Y�	c7E��(��(��b�,2cEp��F.�4��8I����?y�2孜T8�q��*���q|nd��ؼ<zUl3U���N�;M�Slxl���ܺ��R��-�r�o�Ƃ3��C��y�'q��r���Τ�!�i�Ɓ<����5ha;��)Q�����=Ư�8�? p��(     