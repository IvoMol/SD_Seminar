table 50101 "CSD Seminar"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 5 - Lab 3-2 & Lab 3-3 
{
    Caption = 'Seminar';

    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "No." <> xRec."No." then begin
                    SeminarSetup.GET();
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(20; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }
        field(30; "Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration';
            DecimalPlaces = 0 : 1;
            DataClassification = CustomerContent;
        }
        field(40; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
            DataClassification = CustomerContent;
        }
        field(50; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = CustomerContent;
        }
        field(60; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
            DataClassification = CustomerContent;
        }
        field(70; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
        field(80; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist ("CSD Seminar Comment Line" where ("Table Name" = filter ("Seminar"), "No." = Field ("No.")));
        }
        field(100; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            DataClassification = CustomerContent;
        }
        field(110; "Gen. Prod. Posting Group"; code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if (xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group") then
                    if GenProdPostingGroup.ValidateVatProdPostingGroup(GenProdPostingGroup, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", GenProdPostingGroup."Def. VAT Prod. Posting Group");
            end;
        }
        field(120; "VAT Prod. Posting Group"; code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(130; "No. Series"; Code[20])
        {
            Editable = false;
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        SeminarSetup: Record "CSD Seminar Setup";
        CommentLine: Record "CSD Seminar Comment Line";
        Seminar: Record "CSD Seminar";
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert();
    begin
        if "No." = '' then begin
            SeminarSetup.get();
            SeminarSetup.TestField("Seminar Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    trigger OnModify();
    begin
        "Last Date Modified" := Today();
    end;

    trigger OnDelete();
    begin
        CommentLine.Reset();
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::Seminar);
        CommentLine.SetRange("No.", "No.");
        CommentLine.DeleteAll();
    end;

    trigger OnRename();
    begin
        "Last Date Modified" := Today();
    end;

    procedure AssistEdit(): Boolean;
    begin
        with Seminar do begin
            Seminar := Rec;
            SeminarSetup.get();
            SeminarSetup.TestField("Seminar Nos.");
            if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := Seminar;
                exit(true);
            end;
        end;
    end;
}
