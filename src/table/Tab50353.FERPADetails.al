table 50353 "FERPA Details"
{
    Caption = 'FERPA Details';
    DataClassification = CustomerContent;
    LookupPageId = "FERPA Details List";
    DrillDownPageId = "FERPA Details List";

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";
            trigger OnValidate()
            begin
                if StudentRec.Get("Student No.") then begin
                    "Enrolment No." := StudentRec."Enrollment No.";
                    "Student Name" := StudentRec."Student Name";
                    Semester := StudentRec.Semester;
                    "Academic Year" := StudentRec."Academic Year";
                    Term := StudentRec.Term;
                end else begin
                    "Enrolment No." := '';
                    "Student Name" := '';
                    Semester := '';
                    "Academic Year" := '';
                    Term := Term::FALL;
                end;

            end;
        }
        field(2; "Enrolment No."; Code[20])
        {
            Caption = 'Enrolment No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;

        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "First Name"; Text[50])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
        }
        field(7; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
        }
        field(8; "E-Mail Address"; Text[80])
        {
            Caption = 'E-Mail Address';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
            trigger OnValidate()
            var
                FerpaDetail: Record "FERPA Details";
            Begin
                IF Rec."E-Mail Address" <> '' then begin
                    FerpaDetail.Reset();
                    FerpaDetail.SetRange("Student No.", Rec."Student No.");
                    FerpaDetail.SetRange(Semester, Rec.Semester);
                    FerpaDetail.SetRange("Academic Year", Rec."Academic Year");
                    FerpaDetail.SetRange(Term, Rec.Term);
                    FerpaDetail.SetRange("E-Mail Address", Rec."E-Mail Address");
                    //FerpaDetail.SetRange(Relationship, Rec.Relationship);
                    FerpaDetail.SetRange("Info Header No", Rec."Info Header No");
                    If FerpaDetail.FindFirst() then
                        Error('Ferpa Detail already exist for Student %1 whose Academic Year %2, Term %3, Semester %4 and E-mail %5', Rec."Student No.", Rec."Academic Year", Format(Rec.Term), Rec.Semester, Rec."E-Mail Address");
                End;
            end;
        }
        field(9; "Phone Number"; Text[30])
        {
            Caption = 'Phone Number';
            DataClassification = CustomerContent;
        }
        field(10; Relationship; Code[20])
        {
            Caption = 'Relationship';
            TableRelation = "Ferpa Relationship"."Relationship Code";
            trigger OnValidate()
            var
                FerpaRel: Record "Ferpa Relationship";
                FerpaDetail: Record "FERPA Details";
            begin
                if FerpaRel.get(Relationship) then
                    "Relationship Name" := FerpaRel."Relationship Name"
                else
                    "Relationship Name" := '';

                IF Rec.Relationship <> '' then begin
                    FerpaDetail.Reset();
                    FerpaDetail.SetRange("Student No.", Rec."Student No.");
                    FerpaDetail.SetRange(Semester, Rec.Semester);
                    FerpaDetail.SetRange("Academic Year", Rec."Academic Year");
                    FerpaDetail.SetRange(Term, Rec.Term);
                    FerpaDetail.SetRange(Relationship, Rec.Relationship);
                    FerpaDetail.SetRange("E-Mail Address", Rec."E-Mail Address");
                    FerpaDetail.SetRange("Info Header No", Rec."Info Header No");
                    IF FerpaDetail.FindFirst() then
                        Error('Ferpa Detail already exist for Student %1 whose Academic Year %2, Term %3, Semester %4 and Relationship %5', Rec."Student No.", REc."Academic Year", Format(Rec.Term), REc.Semester, REc.Relationship);
                end;
            end;
        }
        field(11; "As of Date"; Date)
        {
            Caption = 'As of Date';
            DataClassification = CustomerContent;
        }
        field(12; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(13; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(14; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Created On';
            Editable = false;

        }
        Field(15; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        Field(16; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = False;
        }
        field(17; "Info Header No"; Code[20])
        {
            Caption = 'Info Header No';
            DataClassification = CustomerContent;
        }
        field(18; "Ferpa Detail Line No"; Integer)
        {
            Caption = 'Ferpa Detail Line No';
            DataClassification = CustomerContent;
        }
        field(19; "Relationship Name"; Text[50])
        {
            Caption = 'Relationship Name';
            DataClassification = CustomerContent;
        }
        field(20; "Addr1"; Text[50])
        {
            Caption = 'Addr1';
            DataClassification = CustomerContent;
        }
        field(21; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
            // TableRelation = "Post Code".City;
            Editable = false;
        }
        field(22; State; Code[20])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "State SLcM CS".Code;
        }
        field(23; "Country Code"; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(24; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(25; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(26; "Addr2"; Text[50])
        {
            Caption = 'Addr2';
            DataClassification = CustomerContent;
        }
        field(27; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(28; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }

    }
    keys
    {
        key(Key1; "Info Header No", "Ferpa Detail Line No")
        {
            Clustered = true;
        }
    }
    var
        StudentRec: Record "Student Master-CS";


    trigger OnInsert()
    begin
        "Created By" := FORMAT(UserId());
        "Created On" := Today();

        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Modified By" := FORMAT(UserId());
        "Modified On" := Today();

        If xRec.Updated = Updated then
            Updated := true;
    end;


}
