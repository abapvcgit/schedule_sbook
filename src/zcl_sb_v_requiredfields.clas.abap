CLASS zcl_sb_v_requiredfields DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_v_supercl_simple
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_frw_validation~execute
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      check_customid IMPORTING iv_customid TYPE s_customer
                     EXPORTING ev_msg      TYPE symsg,
      check_agencynum IMPORTING iv_agencynum TYPE s_agncynum
                      EXPORTING ev_msg       TYPE symsg.
ENDCLASS.



CLASS zcl_sb_v_requiredfields IMPLEMENTATION.


  METHOD /bobf/if_frw_validation~execute.

    DATA(lt_bookigs) = VALUE ztddi_sbook( ).
    DATA:lv_err_msg  TYPE abap_bool.



    DATA(lv_val_time) = /bobf/cm_frw=>co_lifetime_transition..

    IF eo_message IS NOT BOUND.
      eo_message = /bobf/cl_frw_factory=>get_message( ).
    ENDIF.
    io_read->retrieve(
      EXPORTING
        iv_node                 = is_ctx-node_key   " Node Name
        it_key                  = it_key            " Key Table
*        iv_before_image         = abap_false       " Data Element for Domain BOOLE: TRUE (="X") and FALSE (=" ")
*        iv_fill_data            = abap_true        " Data element for domain BOOLE: TRUE (='X') and FALSE (=' ')
*        it_requested_attributes =                  " List of Names (e.g. Fieldnames)
      IMPORTING
*        eo_message              =                  " Message Object
        et_data                 =  lt_bookigs                " Data Return Structure
*        et_failed_key           =                  " Key Table
*        et_node_cat             =                  " Node Category Assignment
    ).

    LOOP AT lt_bookigs REFERENCE INTO DATA(lo_booking).
***  Customer id valitations
      me->check_customid(
        EXPORTING
          iv_customid = lo_booking->customid
        IMPORTING
        ev_msg = DATA(ls_msg)
      ).
      IF ls_msg IS NOT INITIAL.
        eo_message->add_message(
          EXPORTING
            is_msg       =  ls_msg                " Message that is to be added to the message object
            iv_node      =  is_ctx-node_key       " Node to be used in the origin location
            iv_key       =  lo_booking->key       " Instance key to be used in the origin location
            iv_attribute =  zif_dd_i_schedule_c=>sc_node_attribute-zdd_i_sbook-customid                " Attribute to be used in the origin location
            iv_lifetime  =  lv_val_time           " Lifetime of the message
        ).
        lv_err_msg = abap_true.
        CLEAR ls_msg.
      ENDIF.

*** Agencynum Validation
      me->check_agencynum(
        EXPORTING
          iv_agencynum = lo_booking->agencynum
        IMPORTING
          ev_msg       = ls_msg
      ).
      eo_message->add_message(
        EXPORTING
          is_msg       = ls_msg           " Message that is to be added to the message object
          iv_node      = is_ctx-node_key  " Node to be used in the origin location
          iv_key       = lo_booking->key  " Instance key to be used in the origin location
          iv_attribute = zif_dd_i_schedule_c=>sc_node_attribute-zdd_i_sbook-agencynum  " Attribute to be used in the origin location
          iv_lifetime  = lv_val_time      " Lifetime of the message
      ).



      IF lv_err_msg EQ abap_true.
        APPEND INITIAL LINE TO et_failed_key ASSIGNING FIELD-SYMBOL(<ls_failed_key>).
        <ls_failed_key>-key = lo_booking->key.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.


  METHOD check_customid.
    IF iv_customid IS INITIAL.

    ELSE.

      SELECT SINGLE name
      INTO @DATA(lv_name)
      FROM scustom
      WHERE id EQ @iv_customid.
      IF sy-subrc <> 0.
        ev_msg = zcl_sb_cm_sbook=>customid_msg.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD check_agencynum.
    IF iv_agencynum IS INITIAL.

    ELSE.

      SELECT SINGLE agencynum
      INTO @DATA(lv_id)
      FROM stravelag
      WHERE agencynum EQ @iv_agencynum.
      IF sy-subrc <> 0.
        ev_msg = zcl_sb_cm_sbook=>agencynum_msg.
      ENDIF.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
