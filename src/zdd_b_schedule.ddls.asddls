@AbapCatalog.sqlViewName: 'ZVN_B_SCHEDULE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data Definition Schedule Basic View'
define view zdd_b_schedule
  as select from spfli
{

  key carrid,
  key connid,
      countryfr,
      cityfrom,
      airpfrom,
      countryto,
      cityto,
      airpto,
      fltime,
      deptime,
      arrtime,
      distance,
      distid,
      fltype,
      period
}
