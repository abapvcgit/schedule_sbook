@AbapCatalog.sqlViewName: 'ZVN_VH_UNIT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Unit Weight ID Value Help'

@Search.searchable: true
@ObjectModel:{
  resultSet.sizeCategory: #XS // smal size for dropdow helpvalue
}
define view zdd_vh_unitweight
  as select from    t006
    left outer join t006a on t006.msehi = t006a.msehi
{
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['UnitWeightT']
  key t006.msehi  as UnitWeight,
      @Semantics.text: true -- identifies the text field
      t006a.msehl as UnitWeightT

}
where
      t006.dimid  like 'MASS'
  and t006a.spras = $session.system_language
