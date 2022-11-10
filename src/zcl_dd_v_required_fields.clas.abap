CLASS zcl_dd_v_required_fields DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_v_supercl_simple
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_frw_validation~execute
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS : m_carrid IMPORTING iv_carrid TYPE s_carr_id
                       EXPORTING ev_msg    TYPE symsg,
      m_city IMPORTING iv_cityfrom TYPE s_from_cit
                       iv_type     TYPE char1
             EXPORTING ev_msg      TYPE symsg,

      m_distance IMPORTING iv_distance TYPE s_distance
                 EXPORTING ev_msg      TYPE symsg,

      m_airport IMPORTING iv_airport TYPE s_fromairp
                          iv_type    TYPE char1
                EXPORTING ev_msg     TYPE symsg,

      m_time  IMPORTING iv_time TYPE s_dep_time
                        iv_type TYPE char1
              EXPORTING ev_msg  TYPE symsg.
ENDCLASS.



CLASS zcl_dd_v_required_fields IMPLEMENTATION.


  METHOD /bobf/if_frw_validation~execute.

    DATA(lt_schedules) = VALUE ztddi_schedule( ).
    DATA:lv_err_msg TYPE abap_bool.

    IF eo_message IS NOT BOUND.
      eo_message = /bobf/cl_frw_factory=>get_message( ).
    ENDIF.

    io_read->retrieve(
      EXPORTING
        iv_node                 = is_ctx-node_key   " Node Name
        it_key                  = it_key            " Key Table
      IMPORTING
        et_data                 =  lt_schedules     " Data Return Structure

    ).


    LOOP AT lt_schedules REFERENCE INTO DATA(lo_schedule).

*      validate Airline ID
      me->m_carrid(
        EXPORTING
          iv_carrid = lo_schedule->carrid
        IMPORTING
          ev_msg    = DATA(ls_msg)
      ).
      IF ls_msg IS NOT INITIAL.
        eo_message->add_message(
          EXPORTING
            is_msg       = ls_msg            " Message that is to be added to the message object
            iv_node      = is_ctx-node_key   " Node to be used in the origin location
            iv_key       = lo_schedule->key  " Instance key to be used in the origin location
            iv_attribute = zif_cds_i_schedule_c=>sc_node_attribute-zcds_i_schedule-carrid                 " Attribute to be used in the origin location
*            iv_lifetime  =                  " Lifetime of the message
        ).
        lv_err_msg = abap_true.
        CLEAR ls_msg.
      ENDIF.

*      validate  cities
      me->m_city(
        EXPORTING
          iv_cityfrom = lo_schedule->cityfrom
          iv_type    = 'F'
        IMPORTING
          ev_msg      = ls_msg
      ).
      IF ls_msg IS NOT INITIAL.
        eo_message->add_message(
          EXPORTING
            is_msg       = ls_msg            " Message that is to be added to the message object
            iv_node      = is_ctx-node_key   " Node to be used in the origin location
            iv_key       = lo_schedule->key  " Instance key to be used in the origin location
            iv_attribute = zif_cds_i_schedule_c=>sc_node_attribute-zcds_i_schedule-cityfrom                 " Attribute to be used in the origin location
*            iv_lifetime  =                  " Lifetime of the message
        ).
        lv_err_msg = abap_true.
        CLEAR ls_msg.
      ENDIF.

      me->m_city(
          EXPORTING
            iv_cityfrom = lo_schedule->cityto
            iv_type    = 'T'
          IMPORTING
            ev_msg      = ls_msg
        ).
      IF ls_msg IS NOT INITIAL.
        eo_message->add_message(
          EXPORTING
            is_msg       = ls_msg            " Message that is to be added to the message object
            iv_node      = is_ctx-node_key   " Node to be used in the origin location
            iv_key       = lo_schedule->key  " Instance key to be used in the origin location
            iv_attribute = zif_cds_i_schedule_c=>sc_node_attribute-zcds_i_schedule-cityto                 " Attribute to be used in the origin location
*            iv_lifetime  =                  " Lifetime of the message
        ).
        lv_err_msg = abap_true.
        CLEAR ls_msg.
      ENDIF.



*     Validate distance value
      me->m_distance(
        EXPORTING
          iv_distance = lo_schedule->distance
        IMPORTING
          ev_msg      = ls_msg
      ).

      IF ls_msg IS NOT INITIAL.
        eo_message->add_message(
          EXPORTING
            is_msg       = ls_msg            " Message that is to be added to the message object
            iv_node      = is_ctx-node_key   " Node to be used in the origin location
            iv_key       = lo_schedule->key  " Instance key to be used in the origin location
            iv_attribute = zif_cds_i_schedule_c=>sc_node_attribute-zcds_i_schedule-distance                 " Attribute to be used in the origin location
*            iv_lifetime  =                  " Lifetime of the message
        ).
        lv_err_msg = abap_true.
        CLEAR ls_msg.
      ENDIF.

*    validate airports
      me->m_airport(
        EXPORTING
          iv_airport = lo_schedule->airpfrom
          iv_type    = 'F'
        IMPORTING
          ev_msg     = ls_msg
      ).
      IF ls_msg IS NOT INITIAL.
        eo_message->add_message(
          EXPORTING
            is_msg       = ls_msg            " Message that is to be added to the message object
            iv_node      = is_ctx-node_key   " Node to be used in the origin location
            iv_key       = lo_schedule->key  " Instance key to be used in the origin location
            iv_attribute = zif_cds_i_schedule_c=>sc_node_attribute-zcds_i_schedule-airpfrom                 " Attribute to be used in the origin location
*            iv_lifetime  =                  " Lifetime of the message
        ).
        lv_err_msg = abap_true.
        CLEAR ls_msg.
      ENDIF.

      me->m_airport(
      EXPORTING
        iv_airport = lo_schedule->airpto
        iv_type    = 'T'
      IMPORTING
        ev_msg     = ls_msg
       ).
      IF ls_msg IS NOT INITIAL.
        eo_message->add_message(
          EXPORTING
            is_msg       = ls_msg            " Message that is to be added to the message object
            iv_node      = is_ctx-node_key   " Node to be used in the origin location
            iv_key       = lo_schedule->key  " Instance key to be used in the origin location
            iv_attribute = zif_cds_i_schedule_c=>sc_node_attribute-zcds_i_schedule-airpto                 " Attribute to be used in the origin location
*            iv_lifetime  =                  " Lifetime of the message
        ).
        lv_err_msg = abap_true.
        CLEAR ls_msg.
      ENDIF.

*      validate times
      me->m_time(
        EXPORTING
          iv_time = lo_schedule->deptime
          iv_type = 'F'
        IMPORTING
          ev_msg  = ls_msg
      ).
      IF ls_msg IS NOT INITIAL.
        eo_message->add_message(
          EXPORTING
            is_msg       = ls_msg            " Message that is to be added to the message object
            iv_node      = is_ctx-node_key   " Node to be used in the origin location
            iv_key       = lo_schedule->key  " Instance key to be used in the origin location
            iv_attribute = zif_cds_i_schedule_c=>sc_node_attribute-zcds_i_schedule-deptime                 " Attribute to be used in the origin location
*            iv_lifetime  =                  " Lifetime of the message
        ).
        lv_err_msg = abap_true.
        CLEAR ls_msg.
      ENDIF.

      me->m_time(
      EXPORTING
        iv_time = lo_schedule->arrtime
        iv_type = 'T'
      IMPORTING
        ev_msg  = ls_msg
    ).
      IF ls_msg IS NOT INITIAL.
        eo_message->add_message(
          EXPORTING
            is_msg       = ls_msg            " Message that is to be added to the message object
            iv_node      = is_ctx-node_key   " Node to be used in the origin location
            iv_key       = lo_schedule->key  " Instance key to be used in the origin location
            iv_attribute = zif_cds_i_schedule_c=>sc_node_attribute-zcds_i_schedule-arrtime                 " Attribute to be used in the origin location
*            iv_lifetime  =                  " Lifetime of the message
        ).
        lv_err_msg = abap_true.
        CLEAR ls_msg.
      ENDIF.


      IF lv_err_msg EQ abap_true.
        APPEND INITIAL LINE TO et_failed_key ASSIGNING FIELD-SYMBOL(<ls_failed_key>).
        <ls_failed_key>-key = lo_schedule->key.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.
  METHOD m_carrid.
    IF iv_carrid IS INITIAL.
      ev_msg = VALUE #(  msgty =  'E'
                  msgid = '00'
                  msgno = '001'
                  msgv1 = 'Airline ID is required' ).
    ELSE.

      SELECT carrid UP TO 1 ROWS
      FROM scarr
      INTO @DATA(lv_carrid)
      WHERE carrid EQ @iv_carrid.
      ENDSELECT.
      IF sy-subrc <> 0.
        ev_msg = VALUE #(  msgty =  'E'
                  msgid = '00'
                  msgno = '001'
                  msgv1 = 'Enter a valide Airline ID' ).
      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD m_city.

    CONSTANTS : lms_from       TYPE string VALUE 'Depart. city is required',
                lms_to         TYPE string VALUE 'Arrival city is required',
                lms_from_valid TYPE string VALUE 'Enter a valid Depart. city',
                lms_to_valid   TYPE string VALUE 'Enter a valid Arrival city'.

    IF iv_cityfrom IS INITIAL.
      IF iv_type EQ 'F'.

        ev_msg = VALUE #(  msgty =  'E'
                   msgid = '00'
                   msgno = '001'
                   msgv1 = lms_from ).
      ELSEIF iv_type EQ 'T'.
        ev_msg = VALUE #(  msgty =  'E'
                   msgid = '00'
                   msgno = '001'
                   msgv1 = lms_to ).
      ENDIF.
    ELSE.

      SELECT city UP TO 1 ROWS
      INTO @DATA(lv_city)
      FROM sgeocity
      WHERE city EQ @iv_cityfrom.
      ENDSELECT.
      IF sy-subrc <> 0.
        IF iv_type EQ 'F'.
          ev_msg = VALUE #(  msgty =  'E'
                     msgid = '00'
                     msgno = '001'
                     msgv1 = lms_from_valid ).
        ELSEIF iv_type EQ 'T'.
          ev_msg = VALUE #(  msgty =  'E'
                     msgid = '00'
                     msgno = '001'
                     msgv1 = lms_to_valid ).
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD m_distance.
    IF iv_distance IS INITIAL.
      ev_msg = VALUE #(  msgty =  'E'
                 msgid = '00'
                 msgno = '001'
                 msgv1 = 'Distance value is required' ).
    ENDIF.
  ENDMETHOD.

  METHOD m_airport.
    CONSTANTS : lms_from       TYPE string VALUE 'Departure airport is required',
                lms_to         TYPE string VALUE 'Destination airport is required',
                lms_from_valid TYPE string VALUE 'Enter a valid Departure airport',
                lms_to_valid   TYPE string VALUE 'Enter a valid Destination airport'.

    IF iv_airport IS INITIAL.
      IF iv_type EQ 'F'.
        ev_msg = VALUE #(  msgty =  'E'
                msgid = '00'
                msgno = '001'
                msgv1 = lms_from ).
      ELSEIF iv_type EQ 'T'.
        ev_msg = VALUE #(  msgty =  'E'
                msgid = '00'
                msgno = '001'
                msgv1 = lms_to ).
      ENDIF.
    ELSE.

      SELECT SINGLE id
      INTO @DATA(lv_id)
      FROM sairport
      WHERE id EQ @iv_airport.
      IF sy-subrc <> 0.
        IF iv_type EQ 'F'.
          ev_msg = VALUE #(  msgty =  'E'
                  msgid = '00'
                  msgno = '001'
                  msgv1 = lms_from_valid ).
        ELSEIF iv_type EQ 'T'.
          ev_msg = VALUE #(  msgty =  'E'
                  msgid = '00'
                  msgno = '001'
                  msgv1 = lms_to_valid ).
        ENDIF.
      ENDIF.

    ENDIF.

  ENDMETHOD.

  METHOD m_time.
    CONSTANTS : lms_from TYPE string VALUE 'Departure time is required',
                lms_to   TYPE string VALUE 'Arrival Time is required'.
    IF iv_time IS INITIAL.
      IF iv_type EQ 'F'.
        ev_msg = VALUE #(  msgty =  'E'
                msgid = '00'
                msgno = '001'
                msgv1 = lms_from ).
      ELSEIF iv_type EQ 'T'.
        ev_msg = VALUE #(  msgty =  'E'
                msgid = '00'
                msgno = '001'
                msgv1 = lms_to ).
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
