# Subroutine 의 Changing 과 Using의 이해

> Subroutine 내부에서 Global Variable 을 대체할 Local Variable 을 생성해야 함

> 글로벌 변수-로컬변수 값을 전달하기 위해 USING 과 CHANGING 을 사용

USING 에는 서브루틴에서 사용할 참조 변수명 기입 (펑션의 EXPORTING 과 비슷)

CHANGING 은 서브루틴에서 변경된 값을 전달 받을 변수 기입 (펑션의 IMPORTING 과 비슷)

사용 예시
```abap
  DATA: gv_result TYPE i.
  PARAMITER: pa_a type i,
             pa_b type i.
             
* Subroutine 호출.
  FORM xxx USING pa_a
                 pa_b
           CHAINGING gv_result.
  
* Subroutine 내용.
  FORM xxx USING VALUE pv_a TYPE i " Call by Value
                 VALUE pv_b TYPE i " Call by Value
           CHAINGING VALUE pv_result " Call by Value and Result
           CHAINGING pv_result TYPE i. " Call by Reference
  
```
> CALL BY ~ 세 가지 전달 방법
> 
 CALL BY VALUE 
 값이 메인 프로그램으로 전달 되지 않고 서브 루틴 내에서만 변경됨 
 
 CALL BU VALUE RESULT
 서브 루틴에서 변경된 변수의 값이 메인 프로그램에 전달됨
 
 CALL BY REFERENCE
 메인 프로그램의 변수와 서브 루틴의 변수가 연결되어 있음 (동시에 변경되고 전달됨)
 
 
