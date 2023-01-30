## Primary key의 의미

데이터의 고유성을 보장해준다.
해당 키가 설정된 데이터는 유일한 값 

## Foreign Key의 의미

Foreign Key 로 체크테이블과 연결하면 테이블에 데이터를 추가할 때 체크 테이블에 있는 값과 유효성 체크가 된다.

기준이 되는 테이블은 Primary key 값을, 외래 테이블은 Foreign Keys 값으로 연결된다.

## Structure Type에 Foreign Key 연결
![image](https://user-images.githubusercontent.com/122577321/215444718-a67db236-5f05-4c6f-a18a-aab4eecfa2b3.png)
키를 부여할 필드 선택 후 열쇠 모양 아이콘 클릭   
![image](https://user-images.githubusercontent.com/122577321/215444944-4cfa5261-02bc-4ff9-8245-ea9df5e8aafc.png)
체크 테이블 선택
![image](https://user-images.githubusercontent.com/122577321/215445060-f33ad8fe-cde9-4fb4-ab58-478a087565e8.png)
체크 테이블과 필드 확인 후 Copy 버튼 클릭
![image](https://user-images.githubusercontent.com/122577321/215445240-a162b76e-70b3-4cda-b9d8-86bb88e8092b.png)
체크 테이블에 존재하지 않는 ORGEH로 직원 데이터를 생성하려고 했을 때 인풋 체크로 입력이 저지된 상황
체크 테이블과 Foreign Key로 연결 된 테이블은 1:N 의 관계도 많다.
![image](https://user-images.githubusercontent.com/122577321/215445471-1d132879-b530-4cba-9394-405dc934383c.png)
Value Range 탭의 Value Table 에도 체크 테이블을 지정해놓을 수 있다.
해당 도메인에 Forign key 설정할 시 자동 제안됨.
