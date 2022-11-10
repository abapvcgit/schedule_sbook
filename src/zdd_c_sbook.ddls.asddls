@AbapCatalog.sqlViewName: 'ZVN_C_SBOOK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Single Flight Booking'


@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel:{
      createEnabled: true,
      deleteEnabled: true,
      updateEnabled: true,
      usageType:{
         serviceQuality: #X,
         sizeCategory: #S,
         dataClass: #TRANSACTIONAL
      }
}

define view zdd_c_sbook
  as select from zdd_i_sbook as _Booking
  association [1] to zdd_c_schedule as _Schedule on  $projection.carrid = _Schedule.carrid
                                                 and $projection.connid = _Schedule.connid
{
  key carrid,
  key connid,
  key fldate,
      @Search.defaultSearchElement: true
  key bookid,
      customid,
      custtype,
      CustTypeT,
      smoker,
      luggweight,
      wunit,
      invoice,
      class,
      ClassTxt,
      forcuram,
      forcurkey,
      loccuram,
      loccurkey,
      order_date,
      counter,
      agencynum,
      AgencyName,
      cancelled,
      reserved,
      passname,
      passform,
      passbirth,
      /* Associations */
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT,#TO_COMPOSITION_ROOT]
      _Schedule,
      _Flight,
      _Scustom,
      _Custype,
      _Class,
      _Agency,
      _Weight


}
