table 50129 "Class Time Table Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   13/06/2019       OnModify()                                 Code add for Modification Flag
    // 02    CSPL-00114   13/06/2019       Subject Group - OnValidate()               Code added for Subject Group & validation
    // 03    CSPL-00114   13/06/2019       Subject Class - OnValidate()               Code added for Validation
    // 04    CSPL-00114   13/06/2019       Subject Code - OnValidate()                Code added for Subject Name
    // 05    CSPL-00114   13/06/2019       Subject Code - OnLookup()                  Code added for Subject Code,Subject Name & Page LookUp
    // 06    CSPL-00114   13/06/2019       Room No - OnLookup()                       Code added for Room No & Page LookUp
    // 07    CSPL-00114   13/06/2019       Batch - OnValidate()                       Code added for Validation
    // 08    CSPL-00114   13/06/2019       Faculty 1 Code - OnValidate()              Code added for faculty 1 Name
    // 09    CSPL-00114   13/06/2019       Faculty 1 Code - Lookup()                  Code added for Faculty 1 Name & Page Lookup
    // 10    CSPL-00114   13/06/2019       Faculty 1 Start Date - OnValidate()        Code added for Validation
    // 11    CSPL-00114   13/06/2019       Faculty 1 End Date - OnValidate()          Code added for Validation
    // 12    CSPL-00114   13/06/2019       Faculty 2 Code - OnValidate()              Code added for faculty 2 Name
    // 13    CSPL-00114   13/06/2019       Faculty 2 Code - Lookup()                  Code added for Faculty 2 Name & Page Lookup
    // 14    CSPL-00114   13/06/2019       Faculty 2 Start Date - OnValidate()        Code added for Validation
    // 15    CSPL-00114   13/06/2019       Faculty 2 End Date - OnValidate()          Code added for Validation
    // 16    CSPL-00114   13/06/2019       Faculty 3 Code - OnValidate()              Code added for faculty 3 Name
    // 17    CSPL-00114   13/06/2019       Faculty 3 Code - Lookup()                  Code added for Faculty 3 Name & Page Lookup
    // 18    CSPL-00114   13/06/2019       Faculty 3 Start Date - OnValidate()        Code added for Validation
    // 19    CSPL-00114   13/06/2019       Faculty 3 End Date - OnValidate()          Code added for Validation
    // 20    CSPL-00114   13/06/2019       Faculty 4 Code - OnValidate()              Code added for faculty 4 Name
    // 21    CSPL-00114   13/06/2019       Faculty 4 Code - Lookup()                  Code added for Faculty 4 Name & Page Lookup
    // 22    CSPL-00114   13/06/2019       Faculty 4 Start Date - OnValidate()        Code added for Validation
    // 23    CSPL-00114   13/06/2019       Faculty 4 End Date - OnValidate()          Code added for Validation
    // 24    CSPL-00114   13/06/2019       Time Slot - OnValidate()                   Code added for Faculty 1 Start & End Date
    // 25    CSPL-00114   13/06/2019       Interval Type - OnValidate()               Code added for Validation
    // 26    CSPL-00114   13/06/2019       EventDateCheckCS -Function                 Create function for Event Date Calculate & validation Check
    // 27    CSPL-00114   13/06/2019       ForFacultyCheckDuplicacyCS -Function       Create function for Faculty Duplicacy Check
    // 28    CSPL-00114   13/06/2019       DateUpdateCS -Function                     Create function for Date Update
    // 29    CSPL-00114   13/06/2019       ForRoomCheckDuplicacyCS -Function          Create function for Room Duplicacy Check

    Caption = 'Class Time Table Line';
    // DrillDownPageID = "Time Tbl SubPage-CS";
    // LookupPageID = "Time Tbl SubPage-CS";

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
        field(3; "Subject Group"; Code[20])
        {
            Caption = 'Subject Group';
            DataClassification = CustomerContent;
            TableRelation = "Time Table Subject Group-CS";

            trigger OnValidate()
            begin
                //Code added for Subject Group & validation::CSPL-00114::13062019: Start
                IF (Interval = TRUE) and ("Subject Group" <> '') THEN
                    ERROR('Subject Group Cannot Be Allocated In Brake Time !!');

                IF TimeTableSubjectGroupCS.GET("Subject Group") THEN
                    Elective := TimeTableSubjectGroupCS.Elective
                ELSE
                    Elective := FALSE;
                //Code added for Subject Group & validation::CSPL-00114::13062019: End
            end;
        }
        field(4; "Subject Class"; Code[20])
        {
            Caption = 'Suject Class';
            DataClassification = CustomerContent;
            TableRelation = "Subject Classification-CS";
            trigger OnValidate()
            begin
                //Code added for validation::CSPL-00114::13062019: Start
                IF (Interval = TRUE) And ("Subject Class" <> '') THEN
                    ERROR('Subject Class Cannot Be Allocated In Brake Time !!');
                //Code added for validation::CSPL-00114::13062019: End
            end;
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            FieldClass = Normal;
            TableRelation = if ("Level 1 Subject Code" = filter(''), "Time Slot" = filter(<> ''), "Subject Class" = filter(<> 'LAB')) "Subject Master-CS".code
             where(Level = filter(2), "Subject Closed" = filter(false), "Attendance Not Applicable" = filter(false))
            else
            if ("Time Slot" = filter(<> ''), "Subject Class" = filter(<> 'LAB')) "Subject Master-CS".code where("Subject Group" = field("Level 1 Subject Code"), "Subject Closed" = filter(false), "Attendance Not Applicable" = filter(false))
            else
            If ("Subject Class" = filter('LAB')) "Subject Master-CS".code where(Level = Filter(3), "Subject Closed" = filter(false), "Attendance Not Applicable" = filter(false), "Subject Classification" = Field("Subject Class"));

            trigger OnValidate()
            Var
                SubjectFacultyCategoryRec: Record "Subject Faculty Category";
            begin
                //Code added for Subject Name::CSPL-00114::13062019: Start

                IF (Interval = TRUE) and ("Subject Code" <> '') THEN
                    ERROR('Subject Cannot Be Allocated In Brake Time !!');
                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(Code, "Subject Code");
                IF SubjectMasterCS.FINDFIRST() THEN
                    "Subject Name" := SubjectMasterCS.Description
                ELSE
                    "Subject Name" := '';

                SubjectFacultyCategoryRec.Reset();
                SubjectFacultyCategoryRec.SetRange("Subject Code", "Subject Code");
                if SubjectFacultyCategoryRec.FindFirst() then
                    "Subject Category" := SubjectFacultyCategoryRec."Category Code";

            end;
        }
        field(6; "Subject Name"; Text[100])
        {
            Caption = 'Subject Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Room No"; Code[20])
        {
            Caption = 'Room No.';
            DataClassification = CustomerContent;
            //TableRelation = "Rooms-CS";

            trigger OnLookup()
            begin
                //Code added for Room No & Page LookUp::CSPL-00114::13062019: Start
                IF (Interval = TRUE) and ("Room No" <> '') THEN
                    ERROR('No Room Can be Allocated In Brake Time !!');

                RoomsCS.Reset();
                RoomsCS.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                RoomsCS.FINDSET();
                IF PAGE.RUNMODAL(0, RoomsCS) = ACTION::LookupOK THEN begin
                    Rec."Room No" := RoomsCS."Display Room No.";
                    Modify();


                    ClassTimeTableLineCS1.Reset();
                    ClassTimeTableLineCS1.SETRANGE("Document No.", "Document No.");
                    ClassTimeTableLineCS1.SETRANGE("Subject Class", "Subject Class");
                    ClassTimeTableLineCS1.SETRANGE("Subject Group", "Subject Group");
                    ClassTimeTableLineCS1.SETRANGE("Subject Code", "Subject Code");
                    ClassTimeTableLineCS1.SetRange(Day, Rec.Day);
                    ClassTimeTableLineCS1.SetRange("Time Slot", Rec."Time Slot");
                    ClassTimeTableLineCS1.SetFilter("Line No.", '<>%1', Rec."Line No.");
                    If Rec."Start Date" <> 0D then
                        ClassTimeTableLineCS1.SetRange("Start Date", Rec."Start Date");
                    IF ClassTimeTableLineCS1.FINDSET() THEN
                        ClassTimeTableLineCS1.MODIFYALL("Room No", RoomsCS."Display Room No.")


                END;
            end;
            //Code added for Room No & Page LookUp::CSPL-00114::13062019: End

        }
        field(8; Batch; Text[30])
        {
            Caption = 'Lab Group';
            DataClassification = CustomerContent;
            //TableRelation = "Batch-CS".Code;

            // trigger OnValidate()
            // begin
            //     //Code added for Validation::CSPL-00114::13062019: Start
            //     IF (Interval = TRUE) and (Batch <> '') THEN
            //         ERROR('No Batch Can be Allocated In Brake Time !!');
            //     //Code added for Validation::CSPL-00114::13062019: End
            // end;
            Trigger OnValidate()
            begin

                If Section <> '' then
                    If Batch <> '' then
                        Error('Either Small Group/Section Or Lab Group must have as value.');
            end;

            Trigger OnLookup()
            var
                Batch_lRec: Record "Batch-CS";
                BatchDetail_lPage: Page "Batch Detail-CS";
            Begin
                TestField("Subject Class", 'LAB');
                Batch_lRec.Reset();
                Clear(BatchDetail_lPage);
                BatchDetail_lPage.SetTableView(Batch_lRec);
                BatchDetail_lPage.LookupMode := True;
                IF BatchDetail_lPage.RunModal() = Action::LookupOK then begin
                    Repeat
                        If Batch_lRec.Selection then begin
                            IF Batch = '' then
                                Batch := Batch_lRec.Code
                            Else
                                Batch += '|' + Batch_lRec.Code;
                            Batch_lRec.Selection := false;
                            Batch_lRec.Modify();
                        end;
                    until Batch_lRec.Next() = 0;
                end;
                Validate(Batch);
            end;


        }
        field(9; "Faculty 1 Code"; Code[20])
        {
            Caption = 'Faculty ID 1';
            DataClassification = CustomerContent;
            TableRelation = if ("Subject Category" = filter('')) Employee."No."
            else
            if ("Subject Category" = filter(<> '')) Employee."No." where("Faculty Category" = field("Subject Category"));


            trigger OnValidate()
            begin
                //Code added for Faculty Name::CSPL-00114::13062019: Start
                IF Employee.GET("Faculty 1 Code") THEN
                    // "Faculty 1 Name" := Format(Copystr(Employee."Search Name", 1, 80))
                    "Faculty 1 Name" := Employee."First Name" + ' ' + Employee."Last Name"
                ELSE
                    "Faculty 1 Name" := '';

                If Rec."Subject Category" <> '' then begin
                    ClassTimeTableLineCS1.Reset();
                    ClassTimeTableLineCS1.SETRANGE("Document No.", "Document No.");
                    ClassTimeTableLineCS1.SetRange("Subject Category", Rec."Subject Category");
                    ClassTimeTableLineCS1.SetFilter("Line No.", '<>%1', Rec."Line No.");
                    IF ClassTimeTableLineCS1.FINDSET() THEN BEGIN
                        repeat
                            ClassTimeTableLineCS1.ModifyAll("Faculty 1 Code", "Faculty 1 Code");
                            ClassTimeTableLineCS1.ModifyAll("Faculty 1 Name", "Faculty 1 Name");
                        Until ClassTimeTableLineCS1.Next() = 0;
                    END;
                end;
                //Code added for Faculty Name::CSPL-00114::13062019: End
            end;
        }
        field(10; "Faculty 1 Name"; Text[80])
        {
            Caption = 'Faculty Name 1';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Faculty 1 Start Date"; Date)
        {
            Caption = 'Faculty 1 Start Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validation::CSPL-00114::13062019: Start
                //EventDateCheckCS();
                IF (Interval = TRUE) and ("Faculty 1 Start Date" <> 0D) THEN
                    ERROR('Subject Class Cannot Be Allocated In Brake Time !!');
                //Code added for Validation::CSPL-00114::13062019: End
            end;
        }
        field(12; "Faculty 1 End Date"; Date)
        {
            Caption = 'Faculty 1 End Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validation::CSPL-00114::13062019: Start
                IF (Interval = TRUE) and ("Faculty 1 End Date" <> 0D) THEN
                    ERROR('Subject Class Cannot Be Allocated In Brake Time !!');
                //Code added for Validation::CSPL-00114::13062019: End
            end;
        }
        field(13; "Faculty 2 Code"; Code[20])
        {
            Caption = 'Faculty ID 2';
            DataClassification = CustomerContent;
            TableRelation = if ("Subject Category" = filter('')) Employee."No."
            else
            if ("Subject Category" = filter(<> '')) Employee."No." where("Faculty Category" = field("Subject Category"));


            trigger OnValidate()
            begin
                //Code added for Faculty Name::CSPL-00114::13062019: Start
                IF Employee.GET("Faculty 2 Code") THEN
                    "Faculty 2 Name" := Employee."First Name" + ' ' + Employee."Last Name"
                ELSE
                    "Faculty 2 Name" := '';

                If Rec."Subject Category" <> '' then begin
                    ClassTimeTableLineCS1.Reset();
                    ClassTimeTableLineCS1.SETRANGE("Document No.", "Document No.");
                    ClassTimeTableLineCS1.SetRange("Subject Category", Rec."Subject Category");
                    ClassTimeTableLineCS1.SetFilter("Line No.", '<>%1', Rec."Line No.");
                    IF ClassTimeTableLineCS1.FINDSET() THEN BEGIN
                        ClassTimeTableLineCS1.MODIFYALL("Faculty 2 Code", "Faculty 2 Code");
                        ClassTimeTableLineCS1.MODIFYALL("Faculty 2 Name", "Faculty 2 Name");
                    END;
                end;
                //Code added for Faculty Name::CSPL-00114::13062019: End
            end;
        }
        field(14; "Faculty 2 Name"; Text[80])
        {
            Caption = 'Faculty Name 2';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Faculty 2 Start Date"; Date)
        {
            Caption = 'Faculty 2 Start Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for validation::CSPL-00114::13062019: Start
                IF (Interval = TRUE) and ("Faculty 2 Start Date" <> 0D) THEN
                    ERROR('Subject Class Cannot Be Allocated In Brake Time !!');
                //Code added for validation::CSPL-00114::13062019: End
            end;
        }
        field(16; "Faculty 2 End Date"; Date)
        {
            Caption = 'Faculty 2 End Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for validation::CSPL-00114::13062019: Start
                IF (Interval = TRUE) and ("Faculty 2 End Date" <> 0D) THEN
                    ERROR('Subject Class Cannot Be Allocated In Brake Time !!');
                //Code added for validation::CSPL-00114::13062019: End
            end;
        }
        field(17; "Faculty 3 Code"; Code[20])
        {
            Caption = 'Faculty ID 3';
            DataClassification = CustomerContent;
            TableRelation = if ("Subject Category" = filter('')) Employee."No."
            else
            if ("Subject Category" = filter(<> '')) Employee."No." where("Faculty Category" = field("Subject Category"));


            trigger OnValidate()
            begin

                //Code added for Faculty Name::CSPL-00114::13062019: Start
                IF Employee.GET("Faculty 3 Code") THEN
                    "Faculty 3 Name" := Employee."First Name" + ' ' + Employee."Last Name"
                ELSE
                    "Faculty 3 Name" := '';

                If Rec."Subject Category" <> '' then begin
                    ClassTimeTableLineCS1.Reset();
                    ClassTimeTableLineCS1.SETRANGE("Document No.", "Document No.");
                    ClassTimeTableLineCS1.SetRange("Subject Category", Rec."Subject Category");
                    ClassTimeTableLineCS1.SetFilter("Line No.", '<>%1', Rec."Line No.");
                    IF ClassTimeTableLineCS1.FINDSET() THEN BEGIN
                        ClassTimeTableLineCS1.MODIFYALL("Faculty 3 Code", "Faculty 3 Code");
                        ClassTimeTableLineCS1.MODIFYALL("Faculty 3 Name", "Faculty 3 Name");
                    END;
                end;
                //Code added for Faculty Name::CSPL-00114::13062019: End
            end;
        }
        field(18; "Faculty 3 Name"; Text[80])
        {
            Caption = 'Faculty Name 3';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Faculty 3 Start Date"; Date)
        {
            Caption = 'Faculty 3 Start Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

                //Code added for Validate::CSPL-00114::13062019: Start
                IF (Interval = TRUE) and ("Faculty 3 Start Date" <> 0D) THEN
                    ERROR('Subject Class Cannot Be Allocated In Brake Time !!');
                //Code added for Validate::CSPL-00114::13062019: End
            end;
        }
        field(20; "Faculty 3 End Date"; Date)
        {
            Caption = 'Faculty 3 End Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

                //Code added for Validate::CSPL-00114::13062019: Start
                IF (Interval = TRUE) and ("Faculty 3 End Date" <> 0D) THEN
                    ERROR('Subject Class Cannot Be Allocated In Brake Time !!');
                //Code added for Validate::CSPL-00114::13062019: End
            end;
        }
        field(21; "Faculty 4 Code"; Code[20])
        {
            Caption = 'Faculty ID 4';
            DataClassification = CustomerContent;
            TableRelation = if ("Subject Category" = filter('')) Employee."No."
            else
            if ("Subject Category" = filter(<> '')) Employee."No." where("Faculty Category" = field("Subject Category"));



            trigger OnValidate()
            begin

                //Code added for Faculty Name::CSPL-00114::13062019: Start
                IF Employee.GET("Faculty 4 Code") THEN
                    "Faculty 4 Name" := Employee."First Name" + '' + Employee."Last Name"
                ELSE
                    "Faculty 4 Name" := '';

                If Rec."Subject Category" <> '' then begin
                    ClassTimeTableLineCS1.Reset();
                    ClassTimeTableLineCS1.SETRANGE("Document No.", "Document No.");
                    ClassTimeTableLineCS1.SetRange("Subject Category", Rec."Subject Category");
                    ClassTimeTableLineCS1.SetFilter("Line No.", '<>%1', Rec."Line No.");
                    IF ClassTimeTableLineCS1.FINDSET() THEN BEGIN
                        ClassTimeTableLineCS1.MODIFYALL("Faculty 4 Code", "Faculty 4 Code");
                        ClassTimeTableLineCS1.MODIFYALL("Faculty 4 Name", "Faculty 4 Name");
                    END;
                end;
                //Code added for Faculty Name::CSPL-00114::13062019: End
            end;
        }
        field(22; "Faculty 4 Name"; Text[80])
        {
            Caption = 'Faculty Name 4';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(23; "Faculty 4 Start Date"; Date)
        {
            Caption = 'Faculty 4 Start Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validation::CSPL-00114::13062019: Start
                IF (Interval = TRUE) and ("Faculty 4 Start Date" <> 0D) THEN
                    ERROR('Subject Class Cannot Be Allocated In Brake Time !!');
                //Code added for Validation::CSPL-00114::13062019: End
            end;
        }
        field(24; "Faculty 4 End Date"; Date)
        {
            Caption = 'Faculty 4 End Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validation::CSPL-00114::13062019: Start
                IF (Interval = TRUE) and ("Faculty 4 End Date" <> 0D) THEN
                    ERROR('Subject Class Cannot Be Allocated In Brake Time !!');
                //Code added for Validation::CSPL-00114::13062019: End
            end;
        }
        field(25; "Global Dimension 1 Code"; Code[20])
        {

            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(26; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(27; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(28; "Time Slot"; Code[20])
        {
            Caption = 'Time Slot';
            DataClassification = CustomerContent;
            TableRelation = "Time Period-CS"."Slot No";

            trigger OnValidate()
            begin
                //Code added for Faculty 1 Start & End Date::CSPL-00114::13062019: Start
                IF ClassTimeTableHeaderCS.GET("Document No.") then begin
                    "Open Elective" := ClassTimeTableHeaderCS."Open Elective";
                    "Level 1 Subject Code" := ClassTimeTableHeaderCS."Level 1 Subject Code";
                    "Global Dimension 1 Code" := ClassTimeTableHeaderCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := ClassTimeTableHeaderCS."Global Dimension 2 Code";
                    Term := ClassTimeTableHeaderCS.Term;
                end;

                IF "Time Slot" <> '' THEN BEGIN
                    StartEndDateCreation();
                END ELSE
                    IF "Time Slot" = '' THEN BEGIN
                        "Faculty 1 Start Date" := 0D;
                        "Faculty 1 End Date" := 0D;
                    END;

                TimePeriodCS.Reset();
                TimePeriodCS.SETRANGE("Slot No", "Time Slot");
                IF TimePeriodCS.FINDSET() THEN BEGIN
                    "No. of Hours" := (TimePeriodCS."End Time" - TimePeriodCS."Start Time") / 3600000;
                    //Modify();
                END ELSE
                    IF "Time Slot" = '' THEN
                        "No. of Hours" := 0;
                //Code added for Faculty 1 Start & End Date::CSPL-00114::13062019: End
            end;
        }
        field(29; Day; Option)
        {
            Caption = 'Day';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(30; Interval; Boolean)
        {
            Caption = 'Interval';
            DataClassification = CustomerContent;
        }
        field(31; "Interval Type"; Code[20])
        {
            Caption = 'Interval Type';
            DataClassification = CustomerContent;
            TableRelation = "Interval-CS";

            trigger OnValidate()
            begin
                //Code added for Validation::CSPL-00114::13062019: Start
                IF Interval = FALSE THEN
                    ERROR('You cannot enter the Interval Type !!');
                //Code added for Validation::CSPL-00114::13062019: End
            end;
        }
        field(50001; "Created By"; Code[30])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
        }
        field(50002; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
        }
        field(50003; "Modified By"; Code[30])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
        }
        field(50004; "Modified On"; Date)
        {
            Caption = 'Modified On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
        }
        field(50005; "Extra Class"; Boolean)
        {
            Caption = 'Extra Class';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
        }
        field(50006; "Open Elective"; Boolean)
        {
            Caption = 'Open Elective';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
        }
        field(50007; Section; Code[30])
        {
            Caption = 'Small Group / Section';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
            //TableRelation = "Section Master-CS".Code;
            trigger OnValidate()
            begin
                If Batch <> '' then
                    If Section <> '' then
                        Error('Either Small Group/Section Or Lab Group must have as value.');
            end;

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
                Validate(Section);
            End;
        }
        field(50008; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
        }
        field(50009; "Different Faculty"; Boolean)
        {
            Caption = 'Different Faculty';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
        }
        field(50010; "Different Room"; Boolean)
        {
            Caption = 'Different Room';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
        }
        field(50011; Elective; Boolean)
        {
            Caption = 'Elective';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
        }
        field(50012; "Program/Open Elective Temp"; Option)
        {
            Caption = 'Program/Open Elective Temp';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
            OptionCaption = ' ,Open Elective Common Subject,Program Elective Common Subject';
            OptionMembers = " ","Open Elective Common Subject","Program Elective Common Subject";
        }
        field(50013; "OverRide Validation"; Boolean)
        {
            Caption = 'OverRide Validation';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
        }
        field(50014; "No. of Hours"; Decimal)
        {
            Caption = 'No. Of Hours';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
            Editable = true;
        }
        field(50015; "Time Table Status"; Option)
        {
            Caption = 'Time Table Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13062019';
            OptionCaption = 'Open,Released,Generated,Open for Updation,Release For Updation';
            OptionMembers = Open,Released,Generated,"Open for Updation","Release For Updation";
        }
        field(50016; "Goal Code"; Code[20])
        {
            Caption = 'Goal Code';
            DataClassification = CustomerContent;
        }
        field(50017; "Subject Topics"; Option)
        {
            Caption = 'Subject Topics';
            OptionMembers = Subject,Topics;
            OptionCaption = 'Subject,Topics';
        }
        field(50018; "Topics Selected"; Boolean)
        {
            Caption = 'Topics Selected';
            DataClassification = CustomerContent;
        }
        field(50019; "Level 1 Subject Code"; Code[20])
        {
            Caption = 'Level 1 Subject Code';
            DataClassification = CustomerContent;
        }
        field(50020; "Parent Line No."; Integer)
        {
            Caption = 'Parent Line No.';
            DataClassification = CustomerContent;
        }
        Field(50021; "No. of Occurence"; Integer)
        {
            DataClassification = CustomerContent;
        }
        Field(50022; "Subject Category"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Faculty Category";
        }
        Field(50023; "Topic Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code where("Subject Group" = Field("Subject Code"), "Subject Classification" = Field("Subject Class"));
            trigger OnValidate()

            Begin
                IF "Topic Code" <> '' then begin
                    SubjectMasterCS.Reset();
                    SubjectMasterCS.SetRange(Code, "Topic Code");
                    IF SubjectMasterCS.FindFirst() then
                        "Topic Description" := SubjectMasterCS.Description;
                end ELse
                    "Topic Description" := '';
            End;

        }
        Field(50024; "Topic Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(50025; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                DateRec: Record Date;
            begin
                IF Rec.Day <> Rec.Day::" " then begin
                    DateRec.Reset();
                    DateRec.SetRange("Period Type", DateRec."Period Type"::Date);
                    DateRec.SetRange("Period Name", Format(Rec.Day));
                    DateRec.SetRange("Period Start", Rec."Start Date");
                    IF Not DateRec.FindFirst() then
                        Error('Date : %1 not matched with Day : %2.', Rec."Start Date", Rec.Day);
                end;
            end;
        }
        Field(50026; "Final Time Table No."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = False;
            Caption = 'Time Table Line Grouping';
        }

        Field(50027; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50028; Term; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = "FALL","SPRING","SUMMER";
        }

    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Subject Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //Code added for Mpdification Flag::CSPL-00114::13062019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        // "Modified By" := FORMAT(UserId());
        // "Modified On" := TODAY();
        //Code added for Mpdification Flag::CSPL-00114::13062019: End
    end;

    trigger OnInsert()
    Begin

        // "Created By" := UserId();
        // "Created On" := Today();
        Inserted := true;

    End;

    var
        SubjectMasterCS: Record "Subject Master-CS";
        Employee: Record Employee;
        ClassTimeTableHeaderCS: Record "Class Time Table Header-CS";

        //  TimeTableLine: Record "Class Time Table Line-CS";

        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        ClassTimeTableHeaderCS1: Record "Class Time Table Header-CS";
        EducationSetupCS1: Record "Education Setup-CS";

        //  CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        RoomsCS: Record "Rooms-CS";
        FacultyCourseWiseCS1: Record "Faculty Course Wise-CS";
        FacultyCourseWiseCS2: Record "Faculty Course Wise-CS";
        FacultyCourseWiseCS3: Record "Faculty Course Wise-CS";
        FacultyCourseWiseCS4: Record "Faculty Course Wise-CS";
        ClassTimeTableLineCS1: Record "Class Time Table Line-CS";
        ClassTimeTableLineCS2: Record "Class Time Table Line-CS";
        ClassTimeTableLineCS3: Record "Class Time Table Line-CS";
        ClassTimeTableLineCS4: Record "Class Time Table Line-CS";
        TimeTableSubjectGroupCS: Record "Time Table Subject Group-CS";
        TimePeriodCS: Record "Time Period-CS";
        EmployeeRec: Record Employee;

    procedure EventDateCheckCS()
    var
        EduCalendarMultiEventEntry: Record "Education Multi Event Cal-CS";
        EducationSetup: Record "Education Setup-CS";
        EventStartDate: Date;
        EventRevisedDate: Date;

        Text_10001Lbl: Label '%1 Can''t Be Less Than %2 !! ';
        Text_10002Lbl: Label '%1 Can''t Be More Than %2 !! ';
    begin
        //Create function for Event Date Calculate & validation Check::CSPL-00114::13062019: Start
        ClassTimeTableHeaderCS.Reset();
        ClassTimeTableHeaderCS.SETRANGE("No.", "Document No.");
        IF ClassTimeTableHeaderCS.FINDFIRST() THEN BEGIN
            EducationSetup.Reset();
            EducationSetup.SETRANGE("Global Dimension 1 Code", ClassTimeTableHeaderCS."Global Dimension 1 Code");
            IF EducationSetup.FINDFIRST() THEN BEGIN
                IF EducationSetup."Even/Odd Semester" = EducationSetup."Even/Odd Semester"::SPRING THEN BEGIN
                    EduCalendarMultiEventEntry.Reset();
                    EduCalendarMultiEventEntry.SETRANGE("Event Code", 'ODD SEM CLASS START');
                    EduCalendarMultiEventEntry.SETRANGE("Academic Year", ClassTimeTableHeaderCS."Academic Year");
                    IF EduCalendarMultiEventEntry.FINDFIRST() THEN BEGIN
                        EventStartDate := EduCalendarMultiEventEntry."Start Date";
                        EventRevisedDate := EduCalendarMultiEventEntry."Revised End Date";
                    END;
                END ELSE
                    IF EducationSetup."Even/Odd Semester" = EducationSetup."Even/Odd Semester"::FALL THEN BEGIN
                        EduCalendarMultiEventEntry.Reset();
                        EduCalendarMultiEventEntry.SETRANGE("Event Code", 'EVENSEMCLASSSTART');
                        EduCalendarMultiEventEntry.SETRANGE("Academic Year", ClassTimeTableHeaderCS."Academic Year");
                        IF EduCalendarMultiEventEntry.FINDFIRST() THEN BEGIN
                            EventStartDate := EduCalendarMultiEventEntry."Start Date";
                            EventRevisedDate := EduCalendarMultiEventEntry."Revised End Date";
                        END;
                    END;

                IF "Faculty 1 Start Date" <> 0D THEN
                    IF "Faculty 1 Start Date" < EventStartDate THEN
                        ERROR(Text_10001Lbl, Rec.FIELDCAPTION("Faculty 1 Start Date"), EventStartDate);

                IF "Faculty 1 Start Date" <> 0D THEN
                    IF "Faculty 1 Start Date" > EventRevisedDate THEN
                        ERROR(Text_10002Lbl, Rec.FIELDCAPTION("Faculty 1 Start Date"), EventRevisedDate);

                IF "Faculty 1 End Date" <> 0D THEN
                    IF "Faculty 1 End Date" > EventRevisedDate THEN
                        ERROR(Text_10002Lbl, Rec.FIELDCAPTION("Faculty 1 End Date"), EventRevisedDate);

                IF "Faculty 2 Start Date" <> 0D THEN
                    IF "Faculty 2 Start Date" > EventRevisedDate THEN
                        ERROR(Text_10002Lbl, Rec.FIELDCAPTION("Faculty 2 Start Date"), EventRevisedDate);

                IF "Faculty 2 End Date" <> 0D THEN
                    IF "Faculty 2 End Date" > EventRevisedDate THEN
                        ERROR(Text_10002Lbl, Rec.FIELDCAPTION("Faculty 2 End Date"), EventRevisedDate);

                IF "Faculty 3 Start Date" <> 0D THEN
                    IF "Faculty 3 Start Date" > EventRevisedDate THEN
                        ERROR(Text_10002Lbl, Rec.FIELDCAPTION("Faculty 3 Start Date"), EventRevisedDate);

                IF "Faculty 3 End Date" <> 0D THEN
                    IF "Faculty 3 End Date" > EventRevisedDate THEN
                        ERROR(Text_10002Lbl, Rec.FIELDCAPTION("Faculty 3 End Date"), EventRevisedDate);

                IF "Faculty 4 Start Date" <> 0D THEN
                    IF "Faculty 4 Start Date" > EventRevisedDate THEN
                        ERROR(Text_10002Lbl, Rec.FIELDCAPTION("Faculty 4 Start Date"), EventRevisedDate);

                IF "Faculty 4 End Date" <> 0D THEN
                    IF "Faculty 4 End Date" > EventRevisedDate THEN
                        ERROR(Text_10002Lbl, Rec.FIELDCAPTION("Faculty 4 End Date"), EventRevisedDate);

            END;
        END;
        //Create function for Event Date Calculate & validation Check::CSPL-00114::13062019: End;
    end;

    procedure ForFacultyCheckDuplicacyCS()
    var
        FinalClassTimeTableCS: Record "Final Class Time Table-CS";
        FinalClassTimeTableCS1: Record "Final Class Time Table-CS";
        Text_10001Lbl: Label '%1  Already Assigned For Same Date ( %2 ) And Time Slot ( %3 )  !!';
    begin
        //Create function for Faculty Duplicacy Check:CSPL-00114::13062019: Start
        IF NOT "OverRide Validation" THEN
            IF "Faculty 1 Code" <> '' THEN BEGIN
                TESTFIELD("Faculty 1 Start Date");
                TESTFIELD("Faculty 1 End Date");
                FinalClassTimeTableCS.Reset();
                FinalClassTimeTableCS.SETFILTER(Date, '>=%1', "Faculty 1 Start Date");
                FinalClassTimeTableCS.SETFILTER(Date, '<=%1', "Faculty 1 End Date");
                FinalClassTimeTableCS.SETRANGE("Faculty 1Code", "Faculty 1 Code");
                IF FinalClassTimeTableCS.FINDSET() THEN
                    REPEAT
                        FinalClassTimeTableCS1.Reset();
                        FinalClassTimeTableCS1.SETRANGE(Date, FinalClassTimeTableCS.Date);
                        FinalClassTimeTableCS1.SETRANGE("Time Slot Code", "Time Slot");
                        FinalClassTimeTableCS1.SETRANGE("Faculty 1Code", "Faculty 1 Code");
                        IF FinalClassTimeTableCS1.FINDFIRST() THEN
                            ERROR(Text_10001Lbl, "Faculty 1 Code", FinalClassTimeTableCS1.Date, "Time Slot");
                    UNTIL FinalClassTimeTableCS.NEXT() = 0;
            END ELSE
                IF "Faculty 2 Code" <> '' THEN BEGIN
                    TESTFIELD("Faculty 2 Start Date");
                    TESTFIELD("Faculty 2 End Date");
                    FinalClassTimeTableCS.Reset();
                    FinalClassTimeTableCS.SETFILTER(Date, '>=%1', "Faculty 2 Start Date");
                    FinalClassTimeTableCS.SETFILTER(Date, '<=%1', "Faculty 2 End Date");
                    FinalClassTimeTableCS.SETRANGE("Faculty 1Code", "Faculty 2 Code");
                    IF FinalClassTimeTableCS.FINDSET() THEN
                        REPEAT
                            FinalClassTimeTableCS1.Reset();
                            FinalClassTimeTableCS1.SETRANGE(Date, FinalClassTimeTableCS.Date);
                            FinalClassTimeTableCS1.SETRANGE("Time Slot Code", "Time Slot");
                            FinalClassTimeTableCS1.SETRANGE("Faculty 1Code", "Faculty 2 Code");
                            IF FinalClassTimeTableCS1.FINDFIRST() THEN
                                ERROR(Text_10001Lbl, "Faculty 2 Code", FinalClassTimeTableCS1.Date, "Time Slot");
                        UNTIL FinalClassTimeTableCS.NEXT() = 0;
                END ELSE
                    IF "Faculty 3 Code" <> '' THEN BEGIN
                        TESTFIELD("Faculty 3 Start Date");
                        TESTFIELD("Faculty 3 End Date");
                        FinalClassTimeTableCS.Reset();
                        FinalClassTimeTableCS.SETFILTER(Date, '>=%1', "Faculty 3 Start Date");
                        FinalClassTimeTableCS.SETFILTER(Date, '<=%1', "Faculty 3 End Date");
                        FinalClassTimeTableCS.SETRANGE("Faculty 1Code", "Faculty 3 Code");
                        IF FinalClassTimeTableCS.FINDSET() THEN
                            REPEAT
                                FinalClassTimeTableCS1.Reset();
                                FinalClassTimeTableCS1.SETRANGE(Date, FinalClassTimeTableCS.Date);
                                FinalClassTimeTableCS1.SETRANGE("Time Slot Code", "Time Slot");
                                FinalClassTimeTableCS1.SETRANGE("Faculty 1Code", "Faculty 3 Code");
                                IF FinalClassTimeTableCS1.FINDFIRST() THEN
                                    ERROR(Text_10001Lbl, "Faculty 3 Code", FinalClassTimeTableCS1.Date, "Time Slot");
                            UNTIL FinalClassTimeTableCS.NEXT() = 0;
                    END ELSE
                        IF "Faculty 4 Code" <> '' THEN BEGIN
                            TESTFIELD("Faculty 4 Start Date");
                            TESTFIELD("Faculty 4 End Date");
                            FinalClassTimeTableCS.Reset();
                            FinalClassTimeTableCS.SETFILTER(Date, '>=%1', "Faculty 4 Start Date");
                            FinalClassTimeTableCS.SETFILTER(Date, '<=%1', "Faculty 4 End Date");
                            FinalClassTimeTableCS.SETRANGE("Faculty 1Code", "Faculty 4 Code");
                            IF FinalClassTimeTableCS.FINDSET() THEN
                                REPEAT
                                    FinalClassTimeTableCS1.Reset();
                                    FinalClassTimeTableCS1.SETRANGE(Date, FinalClassTimeTableCS.Date);
                                    FinalClassTimeTableCS1.SETRANGE("Time Slot Code", "Time Slot");
                                    FinalClassTimeTableCS1.SETRANGE("Faculty 1Code", "Faculty 4 Code");
                                    IF FinalClassTimeTableCS1.FINDFIRST() THEN
                                        ERROR(Text_10001Lbl, "Faculty 4 Code", FinalClassTimeTableCS1.Date, "Time Slot");
                                UNTIL FinalClassTimeTableCS.NEXT() = 0;
                        END;

        //Create function for Faculty Duplicacy Check:CSPL-00114::13062019: End
    end;

    procedure DateUpdateCS()
    var

    begin
        //Create function for Date Update:CSPL-00114::13062019: Start
        ClassTimeTableHeaderCS1.Reset();
        ClassTimeTableHeaderCS1.SETRANGE("No.", "Document No.");
        IF ClassTimeTableHeaderCS1.FINDFIRST() THEN BEGIN
            EducationSetupCS1.Reset();
            EducationSetupCS1.SETRANGE("Global Dimension 1 Code", ClassTimeTableHeaderCS1."Global Dimension 1 Code");
            IF EducationSetupCS1.FINDFIRST() THEN
                IF EducationSetupCS1."Even/Odd Semester" = EducationSetupCS1."Even/Odd Semester"::SPRING THEN BEGIN
                    EducationMultiEventCalCS.Reset();
                    EducationMultiEventCalCS.SETRANGE("Event Code", 'ODD SEM CLASS START');
                    EducationMultiEventCalCS.SETRANGE("Academic Year", ClassTimeTableHeaderCS1."Academic Year");
                    IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                        IF "Faculty 1 End Date" = EducationMultiEventCalCS."Revised End Date" THEN
                            ERROR('Please Updated Faculty 1 End Date');
                        IF "Faculty 2 End Date" = EducationMultiEventCalCS."Revised End Date" THEN
                            ERROR('Please Updated Faculty 2 End Date');
                        IF "Faculty 3 End Date" = EducationMultiEventCalCS."Revised End Date" THEN
                            ERROR('Please Updated Faculty 3 End Date');

                    END ELSE
                        IF EducationSetupCS1."Even/Odd Semester" = EducationSetupCS1."Even/Odd Semester"::FALL THEN BEGIN
                            EducationMultiEventCalCS.Reset();
                            EducationMultiEventCalCS.SETRANGE("Event Code", 'EVENSEMCLASSSTART');
                            EducationMultiEventCalCS.SETRANGE("Academic Year", ClassTimeTableHeaderCS1."Academic Year");
                            IF EducationMultiEventCalCS.FINDFIRST() THEN
                                IF "Faculty 1 End Date" = EducationMultiEventCalCS."Revised End Date" THEN
                                    ERROR('Please Updated Faculty 1 End Date');
                            IF "Faculty 2 End Date" = EducationMultiEventCalCS."Revised End Date" THEN
                                ERROR('Please Updated Faculty 2 End Date');
                            IF "Faculty 3 End Date" = EducationMultiEventCalCS."Revised End Date" THEN
                                ERROR('Please Updated Faculty 3 End Date');
                        END;

                END;
        END;
        //Create function for Date Update:CSPL-00114::13062019: Start
    end;

    procedure ForRoomCheckDuplicacyCS()
    var
        FinalClassTimeTableCS: Record "Final Class Time Table-CS";
        FinalClassTimeTableCS1: Record "Final Class Time Table-CS";
        Text_10001Lbl: Label '%1  Already Assigned For Same Date ( %2 ) And Time Slot ( %3 )  !!';
    begin
        //Create function for Room Duplicacy Check:CSPL-00114::13062019: Start
        IF NOT "OverRide Validation" THEN BEGIN
            IF "Room No" <> '' THEN
                FinalClassTimeTableCS1.Reset();
            FinalClassTimeTableCS1.SETRANGE(Date, FinalClassTimeTableCS.Date);
            FinalClassTimeTableCS1.SETRANGE("Time Slot Code", "Time Slot");
            FinalClassTimeTableCS1.SETRANGE("Room No", "Room No");
            IF FinalClassTimeTableCS1.FINDFIRST() THEN
                REPEAT
                    ERROR(Text_10001Lbl, "Room No", FinalClassTimeTableCS1.Date, "Time Slot");
                UNTIL FinalClassTimeTableCS.NEXT() = 0;

        END;
        //Create function for Room Duplicacy Check:CSPL-00114::13062019: End
    end;

    Procedure StartEndDateCreation()
    Var
        CourseSemMasterRec: Record "Course Sem. Master-CS";
        ClassTimeTableHRec: Record "Class Time Table Header-CS";
    begin
        ClassTimeTableHRec.Reset();
        ClassTimeTableHRec.SetRange("No.", "Document No.");
        if ClassTimeTableHRec.FindFirst() then;

        CourseSemMasterRec.Reset();
        CourseSemMasterRec.SetRange("Course Code", ClassTimeTableHRec.Course);
        CourseSemMasterRec.SetRange("Academic Year", ClassTimeTableHRec."Academic Year");
        CourseSemMasterRec.SetRange("Semester Code", ClassTimeTableHRec.Semester);
        CourseSemMasterRec.SetRange(Term, ClassTimeTableHRec.Term);
        CourseSemMasterRec.SetRange("Global Dimension 1 Code", ClassTimeTableHRec."Global Dimension 1 Code");
        if CourseSemMasterRec.FindFirst() then begin
            "Faculty 1 Start Date" := CourseSemMasterRec."Start Date";
            "Faculty 1 End Date" := CourseSemMasterRec."End Date";
            "Faculty 2 Start Date" := CourseSemMasterRec."Start Date";
            "Faculty 2 End Date" := CourseSemMasterRec."End Date";
            "Faculty 3 Start Date" := CourseSemMasterRec."Start Date";
            "Faculty 3 End Date" := CourseSemMasterRec."End Date";
            "Faculty 4 Start Date" := CourseSemMasterRec."Start Date";
            "Faculty 4 End Date" := CourseSemMasterRec."End Date";
        end;
    end;
}

