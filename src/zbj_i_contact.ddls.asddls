@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Contact'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zbj_i_contact
  as select from zbj_contact
{
  key contact_id      as ContactId,
      first_name      as FirstName,
      middle_name     as MiddleName,
      last_name       as LastName,
      gender          as Gender,
      dob             as Dob,
      age             as Age,
      telephone       as Telephone,
      email           as Email,
      active          as Active,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt
}
