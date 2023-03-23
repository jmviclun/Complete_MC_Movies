  PROGRAM fillH 
  IMPLICIT NONE

      INTEGER, PARAMETER:: r=SELECTED_REAL_KIND(P=15)
      INTEGER:: m, n, c, i, d, j, k, nmovies, npos, a, b
      INTEGER, ALLOCATABLE:: maxi(:)
      CHARACTER (LEN=75):: firstline, secondline              
      CHARACTER (LEN=4):: atom 

      PRINT*, "" 
      PRINT*,"Number of input lines?"; PRINT*, ""; READ*,n; PRINT*,n
      OPEN(1,FILE="INPUT.pdb",STATUS='OLD', ACTION='READ') 
! initializing variables                               
      PRINT*, "" ; PRINT*, "Number of Movies" ; PRINT*, "" ; READ*, nmovies ; PRINT*, nmovies
      ALLOCATE (maxi(0:nmovies))
      c=0
      d=0
      j=0
      m=1
      DO i=1,n
        READ(1,'(A4)')atom
	IF(atom.eq.'MODE')THEN
	  j=j+1
	  GOTO 10
	END IF
	IF(atom.eq.'CRYS')GOTO 10
	IF(atom.eq.'ATOM')c=c+1
	IF(atom.eq.'ENDM')THEN
	   maxi(j)=c
	   IF(c.ge.d)d=c !; PRINT*, c, d, j
	   c=0
	END IF
10    END DO
      CLOSE (UNIT=1)

      OPEN(1,FILE="INPUT.pdb",STATUS='OLD', ACTION='READ') 
      OPEN(2,FILE="COMPLETED.pdb",STATUS='NEW', ACTION='WRITE') 
      OPEN(3,FILE="MAX.pdb",STATUS='NEW', ACTION='WRITE')
      DO i=1,nmovies
        READ(1,'(A75)')firstline                        
        READ(1,'(A75)')secondline           
        WRITE(2,'(A75)')firstline                        
        WRITE(2,'(A75)')secondline
	IF (maxi(i).eq.d)GOTO 40
	IF (maxi(i).lt.d)GOTO 30
	IF (maxi(i).gt.d) STOP
30	DO k=1,maxi(i)
	   READ(1,'(A75)')firstline; WRITE(2,'(A75)')firstline
        END DO
        DO k=maxi(i)+1,d

	   WRITE(2,'(A4,I7,A61)')'ATOM',k,'H   MOL             0.000   0.000   &
        0.000  1.00  0.00     H'
        END DO 
	GOTO 20
40	DO k=1,maxi(i)
	   READ(1,'(A75)')firstline; WRITE(2,'(A75)')firstline 
           IF (m.le.1) WRITE(3,'(A75)')firstline
        END DO
           m=m+1
20	READ(1,'(A75)')firstline; WRITE(2,'(A75)')firstline
      END DO
      CLOSE (UNIT=1); CLOSE (UNIT=2); CLOSE (UNIT=2)
      PRINT*, ""; PRINT*, 'End of program'; PRINT*, ""

	
 END PROGRAM
