*&---------------------------------------------------------------------*
*& Report ZBC405_E15_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_e15_alv.

TABLES : sflight.

TYPES: BEGIN OF ts_flight.
         INCLUDE TYPE sflight.
TYPES:   excp             TYPE char1,
         color            TYPE char4,
         it_field_colors  TYPE lvc_t_scol,
         changes_possible TYPE icon-id, "테이블 타입이기 때문에 딥 스트럭쳐가 됨
       END OF ts_flight.

* Internal Table & Work area 선언.
DATA: gt_flight      TYPE TABLE OF ts_flight,
      gs_flight      LIKE LINE OF gt_flight,
      gs_field_color TYPE lvc_s_scol,
      ok_code        TYPE sy-ucomm.

* Reference Variable 선언 - For Container Control and ALV Vrid Control.
DATA: go_con TYPE REF TO cl_gui_custom_container,
      go_alv TYPE REF TO cl_gui_alv_grid.

DATA: gv_variant TYPE disvariant,
      gv_save    TYPE c LENGTH 1 VALUE 'A',
      gv_lay     TYPE lvc_s_layo.

* Field Catalog 변수 선언.
DATA: gt_field_cat TYPE lvc_t_fcat.

data: e_per type p LENGTH 4 DECIMALS 2,
      b_per type p LENGTH 4 DECIMALS 2,
      f_per type p LENGTH 4 DECIMALS 2.

INCLUDE zbc405_e15_alv_cls.

SELECTION-SCREEN BEGIN OF BLOCK blk WITH FRAME.
  SELECT-OPTIONS : so_car FOR gs_flight-carrid,
                   so_con FOR gs_flight-connid.
  PARAMETERS: pa_va TYPE disvariant-variant.
SELECTION-SCREEN END OF BLOCK blk.

START-OF-SELECTION.

  SELECT * INTO CORRESPONDING FIELDS OF TABLE gt_flight
    FROM sflight
    WHERE carrid IN so_car
  AND connid IN so_con.

  LOOP AT gt_flight INTO gs_flight.

    IF gs_flight-fldate+0(6) = sy-datum+0(6).
      gs_flight-color = 'C' && col_negative && '01'.
    ENDIF.

    IF gs_flight-seatsocc = 0.
      gs_flight-excp = 1.
    ELSEIF gs_flight-seatsocc < 50.
      gs_flight-excp = 2.
    ELSE.
      gs_flight-excp = 3.
    ENDIF.

    IF gs_flight-planetype = '747-400'.
      gs_field_color-fname = 'PLANETYPE'.
      gs_field_color-color-col = col_positive.
      gs_field_color-color-int = 1.
      gs_field_color-color-inv = 0.
      gs_field_color-nokeycol = 'X'.
      APPEND gs_field_color TO gs_flight-it_field_colors.
    ENDIF.

    IF gs_flight-fldate < sy-datum.
      gs_flight-changes_possible = icon_space.
    ELSE.
      gs_flight-changes_possible = icon_okay.
    ENDIF.

    MODIFY gt_flight FROM gs_flight.
    CLEAR: gs_flight, gs_field_color.

  ENDLOOP.

  CALL SCREEN 100.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'S100'.
  SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'BACK' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Module CREATE_AND_TRANSFER OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE create_and_transfer OUTPUT.

  IF go_con IS INITIAL.
*Custom Container 생성 & Area에 연결.
    CREATE OBJECT go_con
      EXPORTING
        container_name              = 'AREA'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

* ALV Grid 생성 & Custom Contaimer에 연결.
    CREATE OBJECT go_alv
      EXPORTING
        i_parent          = go_con
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

    gv_variant-report = sy-cprog.
    gv_variant-variant = pa_va.
    gv_lay-sel_mode = 'A'.
    gv_lay-grid_title = 'Flight'.
    gv_lay-cwidth_opt = 'X'.
    gv_lay-excp_fname = 'EXCP'.
    gv_lay-info_fname = 'COLOR'.
    gv_lay-no_hgridln = 'X'.
    gv_lay-no_vgridln = 'X'.
    gv_lay-ctab_fname = 'IT_FIELD_COLORS'.

    PERFORM set_fieldcatalog.
    SET HANDLER lcl_event_handler=>on_double_click
    FOR go_alv.

    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
*       i_buffer_active  =
*       i_bypassing_buffer            =
*       i_consistency_check           =
        i_structure_name = 'SFLIGHT'
        is_variant       = gv_variant
        i_save           = gv_save
*       i_default        = 'X'
        is_layout        = gv_lay
*       is_print         =
*       it_special_groups             =
*       it_toolbar_excluding          =
*       it_hyperlink     =
*       it_alv_graphics  =
*       it_except_qinfo  =
*       ir_salv_adapter  =
      CHANGING
        it_outtab        = gt_flight
        it_fieldcatalog  = gt_field_cat
*       it_sort          =
*       it_filter        =
*  EXCEPTIONS
*       invalid_parameter_combination = 1
*       program_error    = 2
*       too_many_lines   = 3
*       others           = 4
      .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.


  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CLEAR_OK_CODE OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE clear_ok_code OUTPUT.
  CLEAR ok_code.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Form set_fieldcatalog
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fieldcatalog .

  DATA: gs_field_cat TYPE lvc_s_fcat.

  gs_field_cat-fieldname = 'SEATSOCC'.
  gs_field_cat-do_sum = 'X'.
  APPEND gs_field_cat TO gt_field_cat.

  CLEAR gs_field_cat.
  gs_field_cat-fieldname = 'PAYMENTSUM'.
  gs_field_cat-no_out = 'X'.
  APPEND gs_field_cat TO gt_field_cat.

  CLEAR gs_field_cat.
  gs_field_cat-fieldname = 'EXCP'.
  gs_field_cat-coltext = 'Utilization'.
  APPEND gs_field_cat TO gt_field_cat.

  CLEAR gs_field_cat.
  gs_field_cat-fieldname = 'CHANGES_POSSIBLE'.
  gs_field_cat-col_pos = 5.
  gs_field_cat-coltext = 'Changes possible'(h03).
  gs_field_cat-tooltip = 'Are changes possible?'(t01).
  APPEND gs_field_cat TO gt_field_cat.


ENDFORM.
*&---------------------------------------------------------------------*
*& Module GET_SEATS OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE get_seats OUTPUT.
  SELECT SINGLE *
    FROM sflight
    WHERE carrid IN so_car
    AND connid IN so_con.

    e_per = sflight-seatsocc / sflight-seatsmax * 100.
    b_per = sflight-seatsocc_b / sflight-seatsmax_b * 100.
    f_per = sflight-seatsocc_f / sflight-seatsmax_f * 100.

ENDMODULE.