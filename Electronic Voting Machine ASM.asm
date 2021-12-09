   
    E BIT P3.5          ;SET P3.5 AS ENABLE PIN
    RW BIT P3.6         ;SET P3.6 AS READ/WRITE PIN
    RS  BIT P3.7         ;SET P3.7 AS REGISTER SELECT PIN
  
    ORG 0000H 
	
	MOV R0,#0
	MOV R1,#0
	MOV R2 ,#0
	MOV R3 ,#0
	MOV R4 ,#0
	MOV P0,#0
	ACALL LCD_COMMANDS
	
	JB P0.0,MAIN
    JNB P0.5 , AGAIN
   
    AGAIN: CJNE R4,#1,DISP2
	
	DISP2: MOV DPTR ,#START_MESG4
           ACALL DISPLAY_LCD_MESG
		   JB P0.0,MAIN
		   ACALL DELAY1
		   ACALL CLRSCRN
		   JB P0.0,MAIN
	       SJMP DISP2
	       
		   
	MAIN: ACALL CLRSCRN
          MOV R4,#1
		  MOV DPTR,#START_MESG1
		  ACALL DISPLAY_LCD_MESG
		  ACALL DELAY
		  ACALL CLRSCRN
		
		
	DISP1:MOV DPTR,#START_MESG2
		  ACALL DISPLAY_LCD_MESG
		  ACALL LINE2
		  MOV DPTR,#START_MESG3
		  ACALL DISPLAY_LCD_MESG
		  ACALL DELAY
		  ACALL CLRSCRN
		  ACALL CHECK
		
		
   CHECK: JB P0.1, NEXT1
		  
		  JB P0.2 ,NEXT2
		  
		  JB P0.3 ,NEXT3
		 
		  JB P0.4 ,NEXT4
		 
		  JB P0.5,RESULT
	      LJMP CHECK
	
	NEXT1: INC R0
				 MOV DPTR,#WAIT
				 ACALL DISPLAY_LCD_MESG
				 ACALL DELAY
				 ACALL CLRSCRN
				 MOV DPTR,#SUCCESS
		         ACALL DISPLAY_LCD_MESG
				 ACALL LINE2
				 MOV DPTR,#THANKS
				 ACALL DISPLAY_LCD_MESG
				 ACALL DELAY2
				 ACALL DELAY1
				 ACALL CLRSCRN
		         SJMP DISP1
	
	
	NEXT2: INC R1
		         MOV DPTR,#WAIT
				 ACALL DISPLAY_LCD_MESG
				 ACALL DELAY
				 ACALL CLRSCRN
				 MOV DPTR,#SUCCESS
		         ACALL DISPLAY_LCD_MESG
				 ACALL LINE2
				 MOV DPTR,#THANKS
				 ACALL DISPLAY_LCD_MESG
				 ACALL DELAY2
				 ACALL DELAY1
				 ACALL CLRSCRN
		         SJMP DISP1
	

	NEXT3: INC R2
		         MOV DPTR,#WAIT
				 ACALL DISPLAY_LCD_MESG
				 ACALL DELAY
				 ACALL CLRSCRN
				 MOV DPTR,#SUCCESS
		         ACALL DISPLAY_LCD_MESG
				 ACALL LINE2
				 MOV DPTR,#THANKS
				 ACALL DISPLAY_LCD_MESG
				 ACALL DELAY2
				 ACALL DELAY1
				 ACALL CLRSCRN
		         SJMP DISP1
				
	NEXT4: INC R3
		         MOV DPTR,#WAIT
				 ACALL DISPLAY_LCD_MESG
				 ACALL DELAY
				 ACALL CLRSCRN
				 MOV DPTR,#SUCCESS
		         ACALL DISPLAY_LCD_MESG
				 ACALL LINE2
				 MOV DPTR,#THANKS
				 ACALL DISPLAY_LCD_MESG
				 ACALL DELAY2
				 ACALL DELAY1
				 ACALL CLRSCRN
		         LJMP DISP1
	
	RESULT:  ACALL CLRSCRN
	         MOV DPTR,#FINAL
		     ACALL DISPLAY_LCD_MESG
		     ACALL DELAY
			 ACALL CLRSCRN
			 
			 MOV DPTR,#FINAL1
			 ACALL DISPLAY_LCD_MESG
		     ACALL DELAY2
			 ACALL CLRSCRN
			
 			 MOV DPTR,#A_VOTES
			 ACALL DISPLAY_LCD_MESG
			 ACALL DELAY1
			 MOV A, R0
			 ACALL VOTES
			 ACALL SPACE
			 ACALL SPACE
			 ACALL DELAY1
			 
			 MOV DPTR,#B_VOTES
			 ACALL DISPLAY_LCD_MESG
			 ACALL DELAY1
			 MOV A,R1
			 ACALL VOTES
			 ACALL SPACE 
			 ACALL SPACE
			 ACALL DELAY1
		
			 ACALL LINE2
			 
			 MOV DPTR,#C_VOTES
			 ACALL DISPLAY_LCD_MESG
			 ACALL DELAY1
			 MOV A,R2
			 ACALL VOTES
			 ACALL SPACE 
			 ACALL SPACE
			 ACALL DELAY1
			
			 MOV DPTR,#D_VOTES
			 ACALL DISPLAY_LCD_MESG
			 ACALL DELAY1
			 MOV A,R3
			 ACALL VOTES
			 ACALL DELAY1
			 ACALL SPACE
			 ACALL SPACE
			 
			 STOP: LJMP STOP

	VOTES: MOV B,#10
		   DIV AB
		   ADD A,#48D
		   ACALL DATA_WRITE
		   MOV A,B
		   ADD A,#48D
		   ACALL DATA_WRITE
		   RET
		   
	
	START_MESG1: DB "VOTING STARTS.....",0
	START_MESG2: DB "CAST YOUR VOTE",0	
	START_MESG3: DB "A / B / C / D",0
	START_MESG4: DB "PRESS START!!!",0
		  FINAL: DB "ELECTION OVER",0
		 FINAL1: DB "LOADING RESULTS",0
	    A_VOTES: DB "A:",0
		B_VOTES: DB "B:",0
		C_VOTES: DB "C:",0
		D_VOTES: DB "D:",0
		SUCCESS: DB "VOTE CASTED",0
		   WAIT: DB "PLEASE WAIT.....",0
	     THANKS: DB "THANK YOU",0
	
	
	 DELAY: MOV R7,#25
	        HERE1:MOV R6,#100             ;DELAY SUBROUTINE
            HERE2:MOV R5,#200
            HERE3:DJNZ R5,HERE3
                  DJNZ R6,HERE2
				  DJNZ R7,HERE1
        RET
	
	
	  DELAY1: MOV R6,#150            ;DELAY3 SUBROUTINE
        HERE4:MOV R5,#250
        HERE5:DJNZ R5,HERE5
              DJNZ R6,HERE4
        RET
		
		
	  DELAY2: MOV R7,#50
	        HERE6:MOV R6,#150             ;DELAY SUBROUTINE
            HERE7:MOV R5,#100
            HERE8:DJNZ R5,HERE8
                  DJNZ R6,HERE7
				  DJNZ R7,HERE6
        RET	
		
		
	CMD_WRITE:MOV P1,A
              CLR RS               ;CLEAR RS PIN
              CLR RW                ;CLEAR RW PIN FOR TAKING COMMAND
              SETB E
			  ACALL DELAY1
              CLR E                 ;H TO L PULSE TO ENABLE
              RET
	 
	 
	 DATA_WRITE:MOV P1,A
              SETB RS            ;SET RS PIN FOR DATA WRITING
              CLR RW             ;CLEAR RW PIN FOR TAKING COMMAND
              SETB E
			  ACALL DELAY1
              CLR E
              RET	     
	
	
	DISPLAY_LCD_MESG: CLR A                ;CLEAR ACCUMULATOR
                      MOVC A,@A+DPTR       ;MOV DPTR VALUE TO A
                      JZ EXIT
                      ACALL DATA_WRITE        ;CALL DATA_WRITE SUBROUTINE
		              INC DPTR                ; INCREASE VALUE OF DPTR BY 1(TO NEXT MEMORY LOCATION)
                      SJMP DISPLAY_LCD_MESG		 
	
	
	LINE2: MOV A,#0C0H
	       ACALL CMD_WRITE       ;CALL CMD_WRITE SUBROUTINE
	       RET
	
	
	CLRSCRN: MOV A,#01H
	         ACALL CMD_WRITE
			 RET
	
	
    SPACE: MOV A,#14H
           ACALL CMD_WRITE
           RET		   
	 
	 
	 EXIT: RET
	
	
	LCD_COMMANDS:MOV A,#38H             ; 2 LINES AND 5X7 MATRIX
                 ACALL CMD_WRITE        ;CALL CMD_WRITE SUBROUTINE
                 ACALL DELAY1
			  
                 MOV A,#3CH             ;ACTIVATE 2ND LINE OF LCD
                 ACALL CMD_WRITE        ;CALL CMD_WRITE SUBROUTINE
                 ACALL DELAY1
			  
                 MOV A,#0EH              ; LCD ON CURSOR BLINKING
                 ACALL CMD_WRITE          ;CALL CMD_WRITE SUBROUTINE
                 ACALL DELAY1
			  
                 MOV A,#01H              ; CLEAR SCREEN
                 ACALL CMD_WRITE         ;CALL CMD_WRITE SUBROUTINE
                 ACALL DELAY1
			  
                 MOV A,#06H              
                 ACALL CMD_WRITE         ;CALL CMD_WRITE SUBROUTINE
                 ACALL DELAY1
			  RET
			  
	END