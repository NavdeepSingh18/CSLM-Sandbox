table 50127 "Time Table Template Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   12/05/2019       OnModify()                                Code added for Data modification Flag
    // 02    CSPL-00114   12/05/2019       Time Slot - OnValidate()                  Code added for Template Name & Duplicate Record Validation
    // 03    CSPL-00114   12/05/2019       Template Name - OnValidate()              function Call for Duplicate Record Validation
    // 04    CSPL-00114   12/05/2019       Subject Class - OnValidate()              Code for Validation
    // 05    CSPL-00114   12/05/2019       Subject Group - OnValidate()              Code for Duplicate Record Validation Check & Get Elective Group Code
    // 06    CSPL-00114   12/05/2019       Day - OnValidate())                       function Call for Duplicate Record Validation
    // 07    CSPL-00114   12/05/2019       Global Dimension 1 Code - OnValidate()    function Call for Duplicate Record Validation
    // 08    CSPL-00114   12/05/2019       Global Dimension 2 Code - OnValidate()    function Call for Duplicate Record Validation
    // 09    CSPL-00114   12/05/2019       Interval Type - OnValidate()              Code for Validation Check
    // 10    CSPL-00114   12/05/2019       DuplicateCheckCS()                        Create function for Duplicate Record Validation Check

    Caption = 'Time Table Template Line-CS';



    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Time Slot"; Code[20])
        {
            Caption = 'Time Slot';
            DataClassification = CustomerContent;
            TableRelation = "Time Period-CS"."Slot No";

            trigger OnValidate()
            begin
                //Code added for Template Name & Duplicate Record Validation::CSPL-00114::12052019: Start
                DuplicateCheckCS();
                TimeTableTemplateHeadCS.Reset();
                TimeTableTemplateHeadCS.SETRANGE(TimeTableTemplateHeadCS."No.", "Document No.");
                IF TimeTableTemplateHeadCS.FINDFIRST() THEN BEGIN
                    "Template Name" := TimeTableTemplateHeadCS."Template Name";
                    "Global Dimension 1 Code" := TimeTableTemplateHeadCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := TimeTableTemplateHeadCS."Global Dimension 2 Code";
                END ELSE BEGIN
                    "Template Name" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                END;
                //Code added for Template Name & Duplicate Record Validation::CSPL-00114::12052019: End
            end;
        }
        field(4; "Template Name"; Text[100])
        {
            Caption = 'Template Name';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                //function Call for Duplicate Record Validation::CSPL-00114::12052019: Start
                DuplicateCheckCS();
                //function Call for Duplicate Record Validation::CSPL-00114::12052019: End
            end;
        }
        field(5; "Subject Class"; Code[20])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            //TableRelation = "Subject Classification-CS".Code WHERE("Attendance Not Applicable" = FILTER(false));
            TableRelation = "Subject Classification-CS".Code;

            trigger OnValidate()
            var
                TimeTableTemplateHdr: Record "Time Table Template Head-CS";
            begin
                //Code for Validation::CSPL-00114::12052019: Start
                IF Interval = TRUE THEN
                    ERROR('Subject Class Cannot Be Allocated In Brake Time !!');

                If Rec."Subject Class" In ['LECTURE', 'SMALL GROUP'] then begin
                    TimeTableTemplateHdr.Reset();
                    TimeTableTemplateHdr.SetRange("No.", Rec."Document No.");
                    IF TimeTableTemplateHdr.FindFirst() then begin
                        TimeTableTemplateHdr."With Topic Code" := true;
                        TimeTableTemplateHdr.Modify();
                    end;
                end;
                //Code for Validation::CSPL-00114::12052019: End
            end;
        }
        field(6; "Subject Group"; Code[20])
        {
            Caption = 'Subject Group';
            DataClassification = CustomerContent;
            TableRelation = "Time Table Subject Group-CS".Code;

            trigger OnValidate()
            begin
                //Code for Duplicate Record Validation Check & Get Elective Group Code::CSPL-00114::12052019: Start
                IF Interval = TRUE THEN
                    ERROR('Subject Class Cannot Be Allocated In Brake Time !!');

                IF TimeTableSubjectGroupCS.GET("Subject Group") THEN
                    Elective := TimeTableSubjectGroupCS.Elective
                ELSE
                    Elective := FALSE;

                DuplicateCheckCS();
                //Code for Duplicate Record Validation Check & Get Elective Group Code::CSPL-00114::12052019: End
            end;
        }
        field(7; Day; Option)
        {
            Caption = 'Day';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;

            trigger OnValidate()
            begin
                //function Call for Duplicate Record Validation::CSPL-00114::12052019: Start
                DuplicateCheckCS();
                //function Call for Duplicate Record Validation::CSPL-00114::12052019: End
            end;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //function Call for Duplicate Record Validation::CSPL-00114::12052019: Start
                DuplicateCheckCS();
                //function Call for Duplicate Record Validation::CSPL-00114::12052019: End
            end;
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //function Call for Duplicate Record Validation::CSPL-00114::12052019: Start
                DuplicateCheckCS();
                //function Call for Duplicate Record Validation::CSPL-00114::12052019: End
            end;
        }
        field(10; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(11; Interval; Boolean)
        {
            Caption = 'Interval';
            DataClassification = CustomerContent;
        }
        field(12; "Interval Type"; Code[20])
        {
            Caption = 'Interval Type';
            DataClassification = CustomerContent;
            TableRelation = "Interval-CS";

            trigger OnValidate()
            begin
                //Code for Validation Check::CSPL-00114::12052019: Start
                IF Interval = FALSE THEN
                    ERROR('You cannot enter the Interval Type !!');
                //Code for Validation Check::CSPL-00114::12052019: End
            end;
        }
        field(50001; "Created By"; Code[30])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12052019';
        }
        field(50002; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12052019';
        }
        field(50003; "Modified By"; Code[30])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12052019';
        }
        field(50004; "Modified On"; Date)
        {
            Description = 'CS Field Added 12052019';
        }
        field(50005; Elective; Boolean)
        {
            Caption = 'Elective';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12052019';
            Editable = true;
        }
        field(50006; Occurance; Integer)
        {
            DataClassification = CustomerContent;
            Trigger OnValidate()
            var
                SubjectClassification: Record "Subject Classification-CS";
            begin
                If Rec."Subject Class" <> '' then begin
                    SubjectClassification.Reset();
                    SubjectClassification.SetRange(Code, Rec."Subject Class");
                    If SubjectClassification.FindFirst() then
                        If SubjectClassification."Occurence Not Applicale" then
                            Error('Occurance not applicable for %1', Rec."Subject Class");
                end;
            end;
        }
        field(50007; "No. of Session"; Integer)
        {
            DataClassification = CustomerContent;
        }
        Field(50008; "No. of Labs"; Integer)
        {
            DataClassification = CustomerContent;
            Trigger OnValidate()
            var
                SubjectClassification: Record "Subject Classification-CS";
            begin
                If Rec."Subject Class" <> '' then begin
                    SubjectClassification.Reset();
                    SubjectClassification.SetRange(Code, Rec."Subject Class");
                    If SubjectClassification.FindFirst() then
                        If SubjectClassification."Occurence Not Applicale" then
                            Error('Occurance not applicable for %1', Rec."Subject Class");
                end;
            end;
        }
        field(50009; Section; Code[30])
        {
            Caption = 'Small Group / Section';
            DataClassification = CustomerContent;
            trigger OnLookup()
            var
                SectionMaster_lRec: Record "Section Master-CS";
                SectionList_lPage: Page "Sections List-CS";
            Begin
                Clear(SectionList_lPage);
                SectionMaster_lRec.Reset();
                SectionList_lPage.SetTableView(SectionMaster_lRec);
                SectionList_lPage.LookupMode := true;
                IF SectionList_lPage.RunModal() = Action::LookupOK then begin
                    repeat
                        IF SectionMaster_lRec.Selection then begin
                            IF Section = '' then
                                Section := SectionMaster_lRec.Code
                            Else
                                Section += '|' + SectionMaster_lRec.Code;
                            SectionMaster_lRec.Selection := false;
                            SectionMaster_lRec.Modify();
                        end;
                    until SectionMaster_lRec.Next() = 0;
                end;
            End;

        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //Code added for Data modification Flag::CSPL-00114::12052019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Data modification Flag::CSPL-00114::12052019: End
    end;

    var
        TimeTableTemplateHeadCS: Record "Time Table Template Head-CS";
        TimeTableTemplateLineCS: Record "Time Table Template Line-CS";
        TimeTableSubjectGroupCS: Record "Time Table Subject Group-CS";

    procedure DuplicateCheckCS()
    begin
        //Create function for Duplicate Record Validation Check::CSPL-00114::12052019: Start
        // TimeTableTemplateLineCS.Reset();
        // TimeTableTemplateLineCS.SETRANGE(TimeTableTemplateLineCS."Document No.", "Document No.");
        // TimeTableTemplateLineCS.SETRANGE(TimeTableTemplateLineCS."Time Slot", "Time Slot");
        // TimeTableTemplateLineCS.SETRANGE(TimeTableTemplateLineCS."Subject Group", "Subject Group");
        // TimeTableTemplateLineCS.SETRANGE(TimeTableTemplateLineCS.Day, Day);
        // TimeTableTemplateLineCS.SETRANGE(TimeTableTemplateLineCS."Global Dimension 1 Code", "Global Dimension 1 Code");
        // TimeTableTemplateLineCS.SETRANGE(TimeTableTemplateLineCS."Global Dimension 2 Code", "Global Dimension 2 Code");
        // IF TimeTableTemplateLineCS.FINDFIRST() THEN
        //     ERROR('Duplicate Entry is not Allowed');
        //Create function for Duplicate Record Validation Check::CSPL-00114::12052019: End
    end;
}

