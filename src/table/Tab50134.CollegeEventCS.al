table 50134 "College Event-CS"
{
    // version V.001-CS

    Caption = 'College Event-CS';

    fields
    {
        field(1; "Code"; Integer)
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Event"; Text[250])
        {
            Caption = 'Event';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CLEAR(College);
                recUserSetup.Reset();
                IF recUserSetup.GET(UserId()) THEN
                    IF recUserSetup."Global Dimension 1 Code" <> '' THEN
                        College := recUserSetup."Global Dimension 1 Code";
            end;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(4; College; Code[20])
        {
            Caption = 'College';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('COLLEGE'));

            trigger OnLookup()
            begin
                recUserSetup.Reset();
                recUserSetup.SETRANGE(recUserSetup."User ID", UserId());
                recUserSetup.SETFILTER(recUserSetup."Global Dimension 1 Code", '<>%1', '');
                IF recUserSetup.FindFirst() THEN BEGIN
                    DimensionValue.Reset();
                    DimensionValue.SETRANGE(DimensionValue.Code, recUserSetup."Global Dimension 1 Code");
                    IF PAGE.RUNMODAL(0, DimensionValue) = ACTION::LookupOK THEN
                        College := DimensionValue.Code;
                END ELSE
                    IF PAGE.RUNMODAL(0, DimensionValue) = ACTION::LookupOK THEN
                        College := DimensionValue.Code;

                VALIDATE(College);
            end;

            trigger OnValidate()
            var
                Text00001Lbl: Label 'This Is University Event';
            begin
                IF University = TRUE THEN
                    ERROR(Text00001Lbl);
            end;
        }
        field(5; University; Boolean)
        {
            Caption = 'University';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF College <> '' THEN
                    ERROR('This Is College Event');
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DimensionValue: Record "Dimension Value";
        recUserSetup: Record "User Setup";
}

