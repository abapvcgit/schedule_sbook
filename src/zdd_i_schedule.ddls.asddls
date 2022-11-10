@AbapCatalog.sqlViewName: 'ZVN_I_SCHEDULE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data Definition Schedule Composite View'


@ObjectModel:{
    compositionRoot:                true,
    transactionalProcessingEnabled: true,
    writeActivePersistence:         'spfli',
    createEnabled:                  true,
    deleteEnabled:                  true,
    updateEnabled:                  true,
    semanticKey:                    ['Connid'],
    usageType:{
       serviceQuality: #X,
       sizeCategory: #S,
       dataClass: #MIXED
    }
}
define view zdd_i_schedule
  as select from zdd_b_schedule
  association [0..*] to zdd_i_sbook       as _Booking on  $projection.carrid = _Booking.carrid
                                                      and $projection.connid = _Booking.connid
  association [1]    to scarr             as _Airline on  $projection.carrid = _Airline.carrid
  association [1]    to sgeocity          as _From    on  $projection.countryfr = _From.country
                                                      and $projection.cityfrom  = _From.city
  association [1]    to sairport          as _Airfrom on  $projection.airpfrom = _Airfrom.id
  association [1]    to sgeocity          as _To      on  $projection.countryto = _To.country
                                                      and $projection.cityto    = _To.city
  association [1]    to sairport          as _Airto   on  $projection.airpto = _Airto.id
  association [1]    to zdd_vh_fltype     as _Fltype  on  $projection.fltype = _Fltype.DomValue
  association [1]    to zdd_vh_distanceid as _Distid  on  $projection.distid = _Distid.msehi
{
      @Consumption.valueHelpDefinition: [{association: '_Airline' }]
      @ObjectModel:{
                        mandatory:  true ,
                        readOnly: 'EXTERNAL_CALCULATION' ,
                        text.element: ['CarrName'] }
  key carrid,
  key connid,
      _Airline.carrname as CarrName,

      @ObjectModel:{ foreignKey.association: '_From'  }
      countryfr,
      @Consumption.valueHelpDefinition: [{association: '_From' }]
      @ObjectModel:{ mandatory: true }
      cityfrom,
      @Consumption.valueHelpDefinition: [{association: '_Airfrom' }]
      @ObjectModel:{
                    text.element: ['AirportFromN'],
                    mandatory: true
                    }
      airpfrom,
      _Airfrom.name     as AirportFromN,

      @ObjectModel.foreignKey.association: '_To'
      countryto,
      @Consumption.valueHelpDefinition: [{association: '_To' }]
      @ObjectModel:{ mandatory: true }
      cityto,
      @Consumption.valueHelpDefinition: [{association: '_Airto' }]
      @ObjectModel:{
                        text.element: ['AirportToN'],
                        mandatory: true
                        }
      airpto,
      _Airto.name       as AirportToN,

      @ObjectModel.mandatory: true
      deptime,
      @ObjectModel.mandatory: true
      arrtime,
      @ObjectModel.mandatory: true
      @Semantics.quantity.unitOfMeasure: 'Distid'
      distance,
      @ObjectModel.mandatory: true
      @Consumption.valueHelpDefinition: [{association: '_Distid' }]
      distid,
      @Consumption.valueHelpDefinition: [{association: '_Fltype'  }]
      @ObjectModel:{
                    text.element: ['FltypeT'],
                    mandatory: true }
      fltype,
      _Fltype.FltypeT   as FltypeT,
      @ObjectModel.mandatory: true
      period,
      
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Booking,
      _Airline,
      _From,
      _Airfrom,
      _To,
      _Airto,
      _Fltype,
      _Distid
}
