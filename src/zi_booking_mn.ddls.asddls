@AbapCatalog.sqlViewName: 'ZV_BOOKING_MN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS for source table ZTBOOKING_mn'

@Search.searchable: true

@UI: {
        headerInfo: {
        typeName: 'Booking',
        typeNamePlural: 'Bookings',
        title: {
            type: #STANDARD,
            value: 'Booking'
            }
        }
    }

define root view zi_booking_mn
  as select from ztbooking_mn
  association to I_Country  as _Country  on ztbooking_mn.country      = _Country.Country
  association to I_Currency as _Currency on ztbooking_mn.currencycode = _Currency.Currency
{
      @UI.facet: [
         {
           id:       'Booking',
           purpose:  #STANDARD,
           type:     #IDENTIFICATION_REFERENCE,
           label:    'Booking',
           position: 10 }
       ]


      @UI: {
          lineItem: [ { position: 10, importance: #HIGH, label: 'Booking ID' } ],
          identification:[ { position: 10, label: 'Booking ID' } ]
          }

  key booking                   as Booking,
      @UI: {
        lineItem: [ { position: 20, label: 'Customer', importance: #HIGH } ],
        identification:[ { position: 10, label: 'Customer' } ]
      }
      @Search.defaultSearchElement: true

      customername              as CustomerName,
      @UI: {
      lineItem: [ { position: 30, label: 'No of Passengers', importance: #HIGH } ],
      identification:[ { position: 30, label: 'No of Passengers' } ]
      }
      numberofpassengers as NumberOfPassengers,

      @UI: {
           identification:[ { position: 40, label: 'Email' } ]
       }
      emailaddress       as EmailAddress,

      @UI: {
           identification:[ { position: 50, label: 'Country' } ]
       }
      country,

      @UI: {
           identification:[ { position: 60, label: 'Booked On' } ]
       }
      dateofbooking      as DateOfBooking,

      @UI: {   identification:[ { position: 70, label: 'Traveling on' } ]    }
      dateoftravel       as DateOfTravel,


      @UI: {
      lineItem: [ { position: 40, label: 'Cost', importance: #HIGH } ],
      identification:[ { position: 80, label: 'Cost' } ]
      }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cost,

      @UI: { identification:[ { position: 90, label: 'Currency' } ]     }
      @Semantics.currencyCode: true
      currencycode       as CurrencyCode,

      @UI: { identification:[ { position: 100, label: 'Last Changed At' } ] }
      lastchangedat      as LastChangedAt,

      _Country,
      _Currency
}
