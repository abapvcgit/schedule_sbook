@AbapCatalog.sqlViewName: 'ZVN_B_SBOOK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data Definition Booking Basic View'
define view zdd_b_sbook
  as select from sbook
{

  key carrid,
  key connid,
  key fldate,
  key bookid,
      customid,
      custtype,
      cast(smoker as boolean preserving type)     as smoker,
      luggweight,
      wunit,
      invoice,
      class,
      forcuram,
      forcurkey,
      loccuram,
      loccurkey,
      order_date,
      counter,
      agencynum,
      cast(cancelled as boolean preserving type ) as cancelled,
      cast(reserved as boolean  preserving type ) as reserved,
      passname,
      passform,
      passbirth
}
