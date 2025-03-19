
CLASS lcx_office_supply DEFINITION INHERITING FROM cx_static_check.

  PUBLIC SECTION.
    INTERFACES: if_t100_message.

    CONSTANTS:
      BEGIN OF lcx_office_supply,
        msgid TYPE symsgid VALUE 'ZCOA_SYNC2_AA_1',
        msgno TYPE symsgno VALUE '1',
        attr1 TYPE scx_attrname VALUE 'MV_ID',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF lcx_office_supply.

    DATA: mv_id TYPE z_de_office_supply_id READ-ONLY.

    METHODS constructor
      IMPORTING iv_textid   LIKE if_t100_message=>t100key OPTIONAL
                io_previous LIKE previous OPTIONAL
                iv_id       TYPE z_de_office_supply_id OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcx_office_supply IMPLEMENTATION.

  METHOD constructor.

    super->constructor( previous = io_previous ).

    mv_id = iv_id.
    CLEAR me->textid.
    IF iv_textid IS INITIAL.
      if_t100_message~t100key = lcx_office_supply.
    ELSE.
      if_t100_message~t100key = iv_textid.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_office_supplies DEFINITION CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      populate_data,
      get_data
        RETURNING VALUE(rt_office_supply) TYPE z_t_office_supply ,
      set_status_broken
        IMPORTING iv_id TYPE z_de_office_supply_id
        RAISING   lcx_office_supply.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mt_office_supplies TYPE z_t_office_supply.
ENDCLASS.

CLASS lcl_office_supplies IMPLEMENTATION.

  METHOD populate_data.
    mt_office_supplies = VALUE #( ( id = 1 name = 'Chair' status = 'In Use' )
                                  ( id = 2 name = 'table' status = 'New' )
                                  ( id = 3 name = 'Computer' status = 'In Use' ) ).
    APPEND VALUE #( id = 4 name = 'Printer' status = 'In Use' ) TO mt_office_supplies.
  ENDMETHOD.

  METHOD get_data.
    rt_office_supply = mt_office_supplies.
  ENDMETHOD.

  METHOD set_status_broken.
*
*        LOOP AT mt_office_supplies INTO DATA(ls_office_supply) WHERE id = iv_id.
*          ls_office_supply-status = 'Broken'.
*          MODIFY mt_office_supplies FROM ls_office_supply.
*        ENDLOOP.
*      if sy-subrc <> 0.
*        RAISE EXCEPTION TYPE lcx_office_supply EXPORTING iv_id = iv_id.
*    endif.
    "option 2
*    READ TABLE mt_office_supplies ASSIGNING FIELD-SYMBOL(<fs_office_supply>) WITH KEY id = iv_id.
*    IF <fs_office_supply> IS ASSIGNED.
*      <fs_office_supply>-status = 'Broken'.
*    ELSE.
*      RAISE EXCEPTION TYPE lcx_office_supply EXPORTING iv_id = iv_id.
*    ENDIF.
    try.
    mt_office_supplies[ id = iv_id ]-status = 'Broken'.
    catch cx_root into data(lx_root).
     RAISE EXCEPTION TYPE lcx_office_supply EXPORTING iv_id = iv_id io_previous = lx_root.
    endtry.

  ENDMETHOD.

ENDCLASS.
