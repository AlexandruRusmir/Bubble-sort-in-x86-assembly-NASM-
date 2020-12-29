Simple bubble sort algorithm created in Netwide Assembler (32 bit) with asm tools which I can share. 

Pseudocode:

	READ n
	READ array with n elements

	REPEAT
		sw  ← 0
		FOR i  ← 1, n-1 EXECUTE
			IF arr[i] > arr[i+1] THEN
				  sw  ← 1
				  aux ← arr[i]
          			  arr[i] ← arr[i+1]
          			  arr[i+1] ← aux
			ENDIF
		ENDFOR
	UNTIL sw = 0
  	PRINT arr
