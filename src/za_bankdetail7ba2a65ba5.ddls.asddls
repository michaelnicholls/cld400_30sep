/********** GENERATED on 09/29/2020 at 09:05:31 by CB0000000001**************/
 @OData.entitySet.name: 'A_BankDetail' 
 @OData.entityType.name: 'A_BankDetailType' 
 define root abstract entity ZA_BANKDETAIL7BA2A65BA5 { 
 key BankCountry : abap.char( 3 ) ; 
 key BankInternalID : abap.char( 15 ) ; 
 @Odata.property.valueControl: 'BankName_vc' 
 BankName : abap.char( 60 ) ; 
 BankName_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'SWIFTCode_vc' 
 SWIFTCode : abap.char( 11 ) ; 
 SWIFTCode_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'BankGroup_vc' 
 BankGroup : abap.char( 2 ) ; 
 BankGroup_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'BankNumber_vc' 
 BankNumber : abap.char( 15 ) ; 
 BankNumber_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Region_vc' 
 Region : abap.char( 3 ) ; 
 Region_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'StreetName_vc' 
 StreetName : abap.char( 35 ) ; 
 StreetName_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CityName_vc' 
 CityName : abap.char( 35 ) ; 
 CityName_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Branch_vc' 
 Branch : abap.char( 40 ) ; 
 Branch_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 } 
