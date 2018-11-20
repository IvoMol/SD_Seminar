tableextension 50100 "CSD ResourceExt" extends Resource
// CSD1.00 - 2012-06-15 - D. E. Veloper
// Chapter 5 - Lab 1-1
// -	Added new fields:
// -	Internal/External
// -	Maximum Participants
{
    fields
    {
        modify("Profit %")
        {

            trigger OnAfterValidate()
            begin
                Rec.TestField("Unit Cost");
            end;
        }
        modify(Type)
        {
            OptionCaption = 'Instructor,Room';
        }
        field(50101; "CSD Resource Type"; Option)
        {
            Caption = 'Resource Type';
            OptionMembers = Internal,External;
            OptionCaption = 'Internal,External';
            DataClassification = CustomerContent;
        }
        field(50102; "CSD Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = CustomerContent;
        }
        field(50103; "CSD Quantity Per Day"; Decimal)
        {
            Caption = 'Quantity Per Day';
            DataClassification = CustomerContent;
        }
    }
}


