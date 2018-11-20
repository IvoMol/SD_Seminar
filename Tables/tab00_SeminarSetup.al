table 50100 "CSD Seminar Setup"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 5 - Lab 3-1
{
    Caption = 'Seminar Setup';

    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(20; "Seminar Nos."; Code[20])
        {
            Caption = 'Seminar Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(30; "Seminar Registration Nos."; code[20])
        {
            Caption = 'Seminar Registration Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(40; "Posted Seminar Reg. Nos."; code[20])
        {
            Caption = 'Posted Seminar Reg. Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
