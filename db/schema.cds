namespace db;

using {cuid} from '@sap/cds/common';


entity Header_table {
    key doc_id                   : String(20);
        eventTypeName            : String;
        title                    : String;
        status                   : String;
        date_created             : String;

        header_item_rel          : Composition of many Item_table
                                       on header_item_rel.item_header_rel = $self;
        header_supplier_rel      : Composition of many Supplier_table
                                       on header_supplier_rel.supplier_header_rel = $self;
        header_supplier_bid_rel  : Composition of many Supplier_bid_table
                                       on header_supplier_bid_rel.supplier_bid_header_rel = $self;

        header_questionnaire_rel : Composition of many Questionnaire_table
                                       on header_questionnaire_rel.quest_header_rel = $self;

}


entity Item_table {
    key doc_id           : String(20);
    key itemid           : String(20);
        item_name        : String;
        improvise_amount : Integer;
        price            : String;
        quantity         : String;

        item_header_rel  : Association to one Header_table
                               on item_header_rel.doc_id = doc_id;


}


entity Questionnaire_table {
    key doc_id                 : String(20);
    key questionnaire_id       : String(20);
        invitationId           : String(50);
        description            : String;
        type                   : String;

        quest_header_rel       : Association to one Header_table
                                     on quest_header_rel.doc_id = doc_id;


        quest_quest_reply_rel1 : Composition of many Questionnaire_reply_table
                                     on quest_quest_reply_rel1.quest_reply_questionnaire_rel = $self;


        quest_sup_rel          : Association to one Supplier_table
                                     on  quest_sup_rel.doc_id       = doc_id
                                     and quest_sup_rel.invitationId = invitationId;
}


entity Questionnaire_reply_table {
    key doc_id                        : String(20);
    key questionnaire_id              : String(20);
    key invitationId                  : String(50);
        user_reply                    : String;


        quest_reply_questionnaire_rel : Association to one Questionnaire_table
                                            on  quest_reply_questionnaire_rel.questionnaire_id = questionnaire_id
                                            and quest_reply_questionnaire_rel.doc_id           = doc_id
                                            and quest_reply_questionnaire_rel.invitationId     = invitationId; //c


        quest_rep_sup_rel             : Association to one Supplier_table
                                            on  quest_rep_sup_rel.doc_id       = doc_id
                                            and quest_rep_sup_rel.invitationId = invitationId;


        quest_reply_dropdown_rel      : Composition of many Dropdown
                                            on quest_reply_dropdown_rel.Dropdown_ques_reply_rel = $self;//c
        //  quest_reply_dropdown_rel      : Composition of many Dropdown
        //                                     on quest_reply_dropdown_rel.questionnaire_id = $self.questionnaire_id;


}


entity Supplier_table {
    key doc_id                   : String(20);
    key invitationId             : String(50);
        main_invitationId        : String;
        title                    : String;
        smvendor_id              : String;
        phone_main               : String;
        status                   : String;
        award_status             : String;
        award_msg_status         : String;

        supplier_header_rel      : Association to one Header_table
                                       on supplier_header_rel.doc_id = doc_id;


        supplier_to_sbid         : Composition of many Supplier_bid_table
                                       on supplier_to_sbid.supplier_bid_supplier_rel = $self;

        supplier_to_attachment   : Composition of many Attachments_table
                                       on supplier_to_attachment.attachment_supplier_rel = $self;

        sup_questionnaire_rel    : Composition of many Questionnaire_table
                                       on sup_questionnaire_rel.quest_sup_rel = $self;

        sup_questionnaire_relply : Composition of many Questionnaire_reply_table
                                       on sup_questionnaire_relply.quest_rep_sup_rel = $self;
}


entity Supplier_bid_table {
    key doc_id                    : String(20);
    key invitationId              : String(50);
    key item_id                   : String(20);
        eventTypeName             : String;
        leadBid                   : Integer;
        title                     : String;
        item_name                 : String;
        supp_quot_price           : Integer;
        supp_quot_quantity        : Integer;
        price                     : String;
        quantity                  : String;
        status                    : String;
        ariba_status              : String;
        whatsapp_status           : String;
        award_price               : Integer;

        supplier_bid_header_rel   : Association to one Header_table
                                        on supplier_bid_header_rel.doc_id = doc_id;
        supplier_bid_supplier_rel : Association to one Supplier_table
                                        on  supplier_bid_supplier_rel.invitationId = invitationId
                                        and supplier_bid_supplier_rel.doc_id       = doc_id;
}


entity Attachments_table {
    key doc_id                  : String(20);
    key invitationId            : String(50);

        @Core.MediaType  : mediaType
        content                 : LargeBinary;

        @Core.IsMediaType: true
        mediaType               : String;
        fileName                : String;
        size                    : Integer;
        url                     : String;
        attachment_supplier_rel : Association to one Supplier_table
                                      on  attachment_supplier_rel.invitationId = invitationId
                                      and attachment_supplier_rel.doc_id       = doc_id;

}


entity Supplier_reply {
        OriginalRepliedMessageSender : String;
    key SmsMessageSid                : String(100);
        NumMedia                     : String;
        ProfileName                  : String;
        SmsSid                       : String;
        WaId                         : String;
        SmsStatus                    : String;
        Body                         : String;
        ButtonText                   : String;
        To                           : String;
        ButtonPayload                : String;
        NumSegments                  : String;
        ReferralNumMedia             : String;
        MessageSid                   : String;
        AccountSid                   : String;
        OriginalRepliedMessageSid    : String;
        ![From]                      : String;
        ApiVersion                   : String;
}


entity Bid_reply {
    key id        : UUID;
        doc_id    : String;
        item_name : String;
        phone     : String;


}


entity Dropdown {
    key id                      : UUID;
        doc_id                  : String(20);//c
        invitationId            : String(50);//c
        questionnaire_id        : String(20);
        dropdown_value          : String;
        Dropdown_ques_reply_rel : Association to one Questionnaire_reply_table
                                      on  Dropdown_ques_reply_rel.questionnaire_id = questionnaire_id
                                      and Dropdown_ques_reply_rel.invitationId     = invitationId
                                      and Dropdown_ques_reply_rel.doc_id           = doc_id;//c

        //  Dropdown_ques_reply_rel : Association to one Questionnaire_reply_table
        //                               on  Dropdown_ques_reply_rel.questionnaire_id = $self.questionnaire_id;


}
