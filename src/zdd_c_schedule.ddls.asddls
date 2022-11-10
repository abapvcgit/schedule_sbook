@AbapCatalog.sqlViewName: 'ZVN_C_SCHEDULE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Schedule'

@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel:{
      compositionRoot: true,
      transactionalProcessingDelegated: true,
      createEnabled: true,
      deleteEnabled: true,
       updateEnabled: true,
      semanticKey: ['Connid'],
      usageType:{
         serviceQuality: #X,
         sizeCategory: #S,
         dataClass: #TRANSACTIONAL
      }
}
@OData.publish: true
define view zdd_c_schedule
  as select from zdd_i_schedule
  association [0..*] to zdd_c_sbook as _Booking on  $projection.carrid = _Booking.carrid
                                                and $projection.connid = _Booking.connid
{
  key carrid,
      @Search.defaultSearchElement: true
  key connid,
      CarrName,
      countryfr,
      cityfrom,
      airpfrom,
      AirportFromN,
      countryto,
      cityto,
      airpto,
      AirportToN,
      deptime,
      arrtime,
      distance,
      distid,
      fltype,
      FltypeT,
      period,
      /* Associations */

      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Booking,
      _Airfrom,
      _Airline,
      _Airto,
      _Distid,
      _Fltype,
      _From,
      _To
}
