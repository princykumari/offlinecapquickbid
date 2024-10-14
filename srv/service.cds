
using db from '../db/schema';

service WhatsappService {

    
    @odata.offline.enabled
    entity Header_table        as projection on db.Header_table;

 
    @odata.offline.enabled
    entity Supplier_table      as projection on db.Supplier_table;

   
    @odata.offline.enabled
    entity Item_table          as projection on db.Item_table;

    entity Bid_reply           as projection on db.Bid_reply;
     @odata.offline.enabled
    entity Dropdown            as projection on db.Dropdown;

    @odata.offline.enabled
    entity Questionnaire_table as projection on db.Questionnaire_table;

    @odata.offline.enabled
    entity Supplier_bid_table  as projection on db.Supplier_bid_table; 
    // =================================================
    // entity Supplier_bid_table as
    // projection on db.Supplier_bid_table {
    //     *,
    //     supplier_bid_supplier_rel.award_status,

    // };
    // ==================================================
 @odata.offline.enabled
  entity Questionnaire_reply_table  as projection on db. Questionnaire_reply_table; 
// entity Questionnaire_reply_table as
// projection on db.Questionnaire_reply_table {
//     *,
//     quest_reply_questionnaire_rel.description,
//     quest_reply_questionnaire_rel.type
// };
@odata.offline.enabled
 entity supplier_replay           as projection on db.Supplier_reply;
@odata.offline.enabled
 entity Attachments_table      as projection on db.Attachments_table;

 @odata.offline.enabled
 @cds.redirection.target
 entity ZSupplier_table        as projection on db.Supplier_table;
}

