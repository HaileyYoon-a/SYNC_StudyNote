# Subroutine 의 Changing 과 Using의 이해

> Subroutine 내부에서 Global Variable 을 대체할 Local Variable 을 생성해야 함

```abap
  DATA: gv_result TYPE i.
  PARAMITER: pa_a type i,
             pa_b type i.
  * Subroutine 호출.
  FORM xxx USING pa_a
                 pa_b
           CHAINGING gv_result.
  
  * Subroutine 내용.
  FORM xxx USING VALUE pv_a TYPE i "Call by Value
                 VALUE pv_b TYPE i "Call by Value
           CHAINGING VALUE pv_result "Call by Value and Result
           CHAINGING pv_result TYPE i. "Call by Reference
  
```

