## Table Join
테이블을 조인하는 방법은 두 가지 있다.

INNER JOIN : 공통된 데이터만 조인됨
LEFT OUTER JOIN : 왼쪽 테이블을 기준 테이블로 두고 데이터가 조인됨

* * *
## INNER JOIN 방법
```abap
SELECT
        a~carrid
        a~connid
        a~fldate
        a~bookid
        b~id
        b~name
        b~custtype
        c~carrname
        d~countryfr
        d~countryto
        d~cityfrom
        d~cityto
        d~airpfrom
        d~airpto
  INTO CORRESPONDING FIELDS OF TABLE gt_data
  FROM ( ( ( sbook AS a INNER JOIN scustom AS b ON a~customid = b~id )
    INNER JOIN scarr AS c ON a~carrid = c~carrid )
    INNER JOIN spfli AS d ON a~connid = d~connid )
    WHERE b~id IN so_cn
    AND b~custtype IN so_ty
    AND a~fldate IN so_fdt.
    ```

~ 로 테이블과 필드이름을 연결한다.
    
on은 join의 기준이 될 필드로 조인할 테이블의 갯수만큼 기준을 정해줘야 한다.
