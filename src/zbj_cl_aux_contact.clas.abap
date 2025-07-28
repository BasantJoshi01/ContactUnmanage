CLASS zbj_cl_aux_contact DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    " Contact Workae with action code and control.
    TYPES : BEGIN OF lty_contact_intx,
              contact_id  TYPE zbj_contact-contact_id,
              action_code TYPE c LENGTH 1,
              _intx       TYPE zbj_contact_intx,
            END OF lty_contact_intx.

    TYPES : lwa_contact TYPE zbj_contact,
            lt_contact  TYPE STANDARD TABLE OF zbj_contact,
            lt_contactx TYPE TABLE OF lty_contact_intx,
            lt_messages TYPE TABLE OF symsg.

    " Get Instance Method

    CLASS-METHODS : get_instance
      RETURNING VALUE(ro_instance) TYPE REF TO zbj_cl_aux_contact.




    CONSTANTS : BEGIN OF ls_constants,

                  BEGIN OF numbering_mode,
                    early TYPE c VALUE 'E',
                    late  TYPE c VALUE 'L',
                  END OF numbering_mode,

                  BEGIN OF operation_action,
                    create TYPE c  VALUE 'C',
                    update TYPE c VALUE 'U',
                    delete TYPE c VALUE 'D',
                  END OF operation_action,

                  message_id TYPE symsg-msgid VALUE 'ZMS_CONTACT_MESSAGES',

                END OF ls_constants.


    METHODS : CreateContact
      IMPORTING iv_contact       TYPE lwa_contact
                iv_NumberingMode TYPE c DEFAULT  ls_constants-numbering_mode-late

      EXPORTING ep_contact       TYPE lwa_contact
                et_meassages     TYPE lt_messages.




  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.





CLASS zbj_cl_aux_contact IMPLEMENTATION.

  METHOD createcontact.

  ENDMETHOD.

  METHOD get_instance.

  ENDMETHOD.

ENDCLASS.
