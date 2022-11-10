CLASS zcl_sb_d_setsbookid DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_d_supercl_simple
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_frw_determination~execute
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sb_d_setsbookid IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.

    DATA(lt_bookings) = VALUE ztddi_sbook( ).
    DATA(lt_schedule) = VALUE ztddi_schedule( ).

    io_read->retrieve(
      EXPORTING
        iv_node                 = is_ctx-node_key   " Node Name
        it_key                  = it_key            " Key Table
*           iv_before_image         = abap_false       " Data Element for Domain BOOLE: TRUE (="X") and FALSE (=" ")
*           iv_fill_data            = abap_true        " Data element for domain BOOLE: TRUE (='X') and FALSE (=' ')
*           it_requested_attributes =                  " List of Names (e.g. Fieldnames)
      IMPORTING
*           eo_message              =                  " Message Object
        et_data                 =  lt_bookings      " Data Return Structure
*           et_failed_key           =                  " Key Table
*           et_node_cat             =                  " Node Category Assignment
    ).

    io_read->retrieve_by_association(
      EXPORTING
        iv_node                 = zif_dd_i_schedule_c=>sc_node-zdd_i_sbook             " Node Name
        it_key                  = it_key           " Key Table
        iv_association          = zif_dd_i_schedule_c=>sc_association-zdd_i_sbook-to_root " Name of Association
*        is_parameters           =
*        it_filtered_attributes  =                  " List of Names (e.g. Fieldnames)
        iv_fill_data            = abap_true       " Data Element for Domain BOOLE: TRUE (="X") and FALSE (=" ")
*        iv_before_image         = abap_false       " Data Element for Domain BOOLE: TRUE (="X") and FALSE (=" ")
*        it_requested_attributes =                  " List of Names (e.g. Fieldnames)
      IMPORTING
*        eo_message              =                  " Message Object
        et_data                 = lt_schedule                 " Data Return Structure
*        et_key_link             =                  " Key Link
*        et_target_key           =                  " Key Table
*        et_failed_key           =                  " Key Table
    ).

    READ TABLE lt_schedule REFERENCE INTO DATA(lo_schedule) INDEX 1.
    IF sy-subrc EQ 0.
      LOOP AT lt_bookings REFERENCE INTO DATA(lo_bookings) WHERE carrid IS INITIAL
                                                           AND connid IS INITIAL.

        lo_bookings->carrid = lo_schedule->carrid.
        lo_bookings->connid = lo_schedule->connid.

        SELECT MAX( bookid ) AS id
        INTO @DATA(lv_bookid)
        FROM sbook
        WHERE carrid = @lo_bookings->carrid
        AND connid = @lo_bookings->connid.

        ADD 1 TO lv_bookid.
        lo_bookings->bookid = lv_bookid.

        IF lo_bookings->order_date IS INITIAL.
          lo_bookings->order_date = sy-datum.
        ENDIF.

        io_modify->update(
          EXPORTING
            iv_node           = is_ctx-node_key   " Node
            iv_key            = lo_bookings->key  " Key
*            iv_root_key       =                  " NodeID
            is_data           =  lo_bookings                " Data
            it_changed_fields =   VALUE #(
                                        ( zif_dd_i_schedule_c=>sc_node_attribute-zdd_i_sbook-carrid )
                                        ( zif_dd_i_schedule_c=>sc_node_attribute-zdd_i_sbook-connid )
                                        ( zif_dd_i_schedule_c=>sc_node_attribute-zdd_i_sbook-bookid ) )
        ).

        CLEAR : lv_bookid.
      ENDLOOP.
      io_modify->end_modify( iv_process_immediately = abap_true ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
