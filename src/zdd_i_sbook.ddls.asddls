@AbapCatalog.sqlViewName: 'ZVN_I_SBOOK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data Definition Booking Composite View'

@ObjectModel:{

     writeActivePersistence: 'sbook',
     createEnabled: true,
     deleteEnabled: true,
     updateEnabled: true,
     usageType:{
        serviceQuality: #X,
        sizeCategory: #S,
        dataClass: #MIXED
     }
}

define view zdd_i_sbook
  as select from zdd_b_sbook
  association [1] to zdd_i_schedule    as _Schedule on  $projection.carrid = _Schedule.carrid
                                                    and $projection.connid = _Schedule.connid
  association [1] to zdd_b_sflight     as _Flight   on  $projection.carrid = _Flight.Carrid
                                                    and $projection.connid = _Flight.Connid
                                                    and $projection.fldate = _Flight.Fldate
  association [1] to scustom           as _Scustom  on  $projection.customid = _Scustom.id
                                                    and $projection.passname = _Scustom.name
                                                    and $projection.passform = _Scustom.form
  association [1] to zdd_vh_custtype   as _Custype  on  $projection.custtype = _Custype.CustType
  association [1] to ZDD_VH_CUSTCLASS  as _Class    on  $projection.class = _Class.Class
  association [1] to stravelag         as _Agency   on  $projection.agencynum = _Agency.agencynum
  association [1] to zdd_vh_unitweight as _Weight   on  $projection.wunit = _Weight.UnitWeight
{

  key  carrid,
  key  connid,
       @ObjectModel:{ mandatory: true }
  key  fldate,
  key  bookid,

       @Consumption.valueHelpDefinition: [{association: '_Scustom' }]
       @ObjectModel:{
                     text.element: ['passname'],
                     mandatory: true
                    }
       customid,
       @Consumption.valueHelpDefinition: [{association: '_Custype' }]
       @ObjectModel:{
                      text.element: ['CustTypeT'],
                      mandatory: true
                    }
       custtype,
       _Custype.CustTypeT as CustTypeT,
       smoker,

       @Semantics.quantity.unitOfMeasure: 'wunit'
       @ObjectModel:{ mandatory: true }
       luggweight,
       @Consumption.valueHelpDefinition: [{association: '_Weight' }]
       @ObjectModel:{ mandatory: true }
       wunit,
       invoice,

       @Consumption.valueHelpDefinition: [{association: '_Class' }]
       @ObjectModel:{
                      text.element: ['ClassTxt'],
                      mandatory: true
                    }
       class,
       _Class.ClassTxt    as ClassTxt,
       @Semantics.amount.currencyCode: 'forcurkey'
       @ObjectModel:{ mandatory: true }
       forcuram,
       forcurkey,
       @Semantics.amount.currencyCode: 'loccurkey'
       @ObjectModel:{ mandatory: true }
       loccuram,
       loccurkey,
       order_date,
       counter,
       @Consumption.valueHelpDefinition: [{association: '_Agency' }]
       @ObjectModel:{
                      text.element: ['AgencyName'],
                      mandatory: true
                    }
       agencynum,
       _Agency.name       as AgencyName,
       cancelled,
       reserved,
       @ObjectModel.foreignKey.association: '_Scustom'
       passname,
       @ObjectModel.foreignKey.association: '_Scustom'
       passform,
       passbirth,

       @ObjectModel.association.type: [#TO_COMPOSITION_PARENT,#TO_COMPOSITION_ROOT]
       _Schedule,
       _Flight,
       _Scustom,
       _Custype,
       _Class,
       _Agency,
       _Weight
}
