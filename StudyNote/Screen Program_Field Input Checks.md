### 하나의 인풋 필드 체크

FIELD [ 체크하고자 하는 필드 이름 ]

MODULE [ 에러 메세지 처리 모듈 ]

### 여러 개의 필드를 한 번에 인풋 체크할 때 CHAIN ~ENDCHAIN. 을 사용한다.
![image](https://user-images.githubusercontent.com/122577321/215638143-ebcd3f61-9ebc-4ed7-a9f8-89670075c232.png)

CHAIN.
[ 체크할 필드 기입]
ENDCHAIN.

### CHECK OPTION

ON REQUEST & ON CHAIN-REQUEST : 새로운 값이 입력됐을 때 실행 

ON INPUT & ON CHAIN-INPUT : 초기값과 다를 때 실행 ( NOT INITIAL)

![image](https://user-images.githubusercontent.com/122577321/215638293-edbbd6dd-8f17-4e74-8400-da126bf6715c.png)

에러 핸들링 메세지 기입
