@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View -  Contact'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zbj_p_contact 
provider contract transactional_query
as projection on zbj_i_contact
{
    key ContactId,
    FirstName,
    MiddleName,
    LastName,
    Gender,
    Dob,
    Age,
    Telephone,
    Email,
    Active,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt
}
