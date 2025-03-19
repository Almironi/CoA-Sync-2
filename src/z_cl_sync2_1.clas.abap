CLASS z_cl_sync2_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_cl_sync2_1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    data(lo_office_supply) = new lcl_office_supplies( ).

    "create entries
    lo_office_supply->populate_data( ).

    out->write( lo_office_supply->get_data( ) ).

    "set status broken
    try.
    lo_office_supply->set_status_broken( iv_id = '14' ).
    CATCH lcx_office_supply into data(lx_office_supply).
        out->write( lx_office_supply->get_text( ) ).
        if lx_office_supply->previous is bound.
          out->write( lx_office_supply->previous->get_text( ) ).
        endif.
    endtry.

    "write changed data
    out->write( lo_office_supply->get_data( ) ).
  ENDMETHOD.
ENDCLASS.
