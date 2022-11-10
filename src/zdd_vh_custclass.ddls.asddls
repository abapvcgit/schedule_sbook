@AbapCatalog.sqlViewName: 'ZVN_VH_CUSTCLASS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Customer Class'


@Search.searchable: true


@ObjectModel:{

  resultSet.sizeCategory: #XS // smal size for dropdow helpvalue
}
define view ZDD_VH_CUSTCLASS
  as select from    dd07l as FixedValue
    left outer join dd07t as ValueText on  FixedValue.domname    = ValueText.domname
                                       and FixedValue.domvalue_l = ValueText.domvalue_l
                                       and FixedValue.as4local   = ValueText.as4local
{
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['ClassTxt']
  key FixedValue.domvalue_l as Class,
      @Semantics.text: true -- identifies the text field
      ValueText.ddtext      as ClassTxt
}

where
      FixedValue.domname   = 'S_CLASS'
  and FixedValue.as4local  = 'A' --Active
  and ValueText.ddlanguage = $session.system_language
