class ZCL_ZDD_C_SCHEDULE definition
  public
  inheriting from CL_SADL_GTK_EXPOSURE_MPC
  final
  create public .

public section.
protected section.

  methods GET_PATHS
    redefinition .
  methods GET_TIMESTAMP
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZDD_C_SCHEDULE IMPLEMENTATION.


  method GET_PATHS.
et_paths = VALUE #(
( |CDS~ZDD_C_SCHEDULE| )
).
  endmethod.


  method GET_TIMESTAMP.
RV_TIMESTAMP = 20221106235233.
  endmethod.
ENDCLASS.
