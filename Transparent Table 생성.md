# 테이블 생성
> Delivery Class 의 종류
![image](https://user-images.githubusercontent.com/122577321/215413853-1cb0839e-d004-4532-8cf9-57d095275771.png)
A: 각 시스템에서 데이터를 직접 제어하는 경우, 일반적으로 많이 사용됨 Customer Table 이라고 함.
C: 데이터를 CTS 가능하게 하여 개발기, QA, 운영기 등이 동일한 데이터를 가져야 할 때 사용됨 Customizing Table 이라고 함.

참고 : https://stepwith.tistory.com/entry/ABAP-%EA%B0%95%EC%A2%8C-3-%ED%85%8C%EC%9D%B4%EB%B8%94-Table-%EC%83%9D%EC%84%B1-1
>Data Brower / Table View Editing 선택 항목의 의미
![image](https://user-images.githubusercontent.com/122577321/215414613-aaf6aa68-4eaa-45e6-b82b-c00d15f952b6.png)
![image](https://user-images.githubusercontent.com/122577321/215414801-26d65139-6142-40e0-bfa9-0ab6e1915208.png)
Display/Maintenance Allowed 유지보수 허용 선택

> Technical Settings
![image](https://user-images.githubusercontent.com/122577321/215414936-4a3e8d4a-1437-4a2e-8a4f-17e448ece433.png)
Data Class와 Size Category 두 가지 항목은 필수 지정.
Data Class : 데이터 베이스의 어떤 영역에 테이블이 저장될지 정의한다.
데이터의 변경 빈도 등을 고려하여 적절한 위치를 할당해야 하지만 현대에는 큰 의미가 없다.
Size Category : 저장 가능한 데이터 건수를 지정. 
 
