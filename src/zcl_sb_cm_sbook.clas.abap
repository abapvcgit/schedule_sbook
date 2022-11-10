CLASS zcl_sb_cm_sbook DEFINITION
  INHERITING FROM /bobf/cm_frw
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

*    CONSTANTS: BEGIN OF fldate_msgid,
*                 msgid TYPE symsgid VALUE '00',
*                 msgno TYPE symsgno VALUE '01',
*                 attr1 TYPE scx_attrname VALUE 'Flight date is required',
*                 attr2 TYPE scx_attrname VALUE '',
*                 attr3 TYPE scx_attrname VALUE '',
*                 attr4 TYPE scx_attrname VALUE '',
*               END OF fldate_msgid,
*               BEGIN OF customid_msgid,
*                 msgid TYPE symsgid VALUE '00',
*                 msgno TYPE symsgno VALUE '01',
*                 attr1 TYPE scx_attrname VALUE 'Enter a valide Customer Number',
*                 attr2 TYPE scx_attrname VALUE '',
*                 attr3 TYPE scx_attrname VALUE '',
*                 attr4 TYPE scx_attrname VALUE '',
*               END OF customid_msgid.
    CONSTANTS: BEGIN OF customid_msg,
                 msgty TYPE symsg-msgty VALUE  /bobf/cm_frw=>co_severity_error,
                 msgid TYPE symsg-msgid VALUE '00',
                 msgno TYPE symsg-msgno VALUE '001',
                 msgv1 TYPE symsg-msgv1 VALUE 'Enter a valide Customer Number',
                 msgv2 TYPE symsgv VALUE '',
                 msgv3 TYPE symsgv VALUE '',
                 msgv4 TYPE symsgv VALUE '',
               END OF customid_msg,
               BEGIN OF agencynum_msg,
                 msgty TYPE symsg-msgty VALUE  /bobf/cm_frw=>co_severity_error,
                 msgid TYPE symsg-msgid VALUE '00',
                 msgno TYPE symsg-msgno VALUE '001',
                 msgv1 TYPE symsg-msgv1 VALUE 'Enter a valide Agency No',
                 msgv2 TYPE symsgv VALUE '',
                 msgv3 TYPE symsgv VALUE '',
                 msgv4 TYPE symsgv VALUE '',
               END OF agencynum_msg
               .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sb_cm_sbook IMPLEMENTATION.
ENDCLASS.
