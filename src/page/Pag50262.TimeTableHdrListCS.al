page 50262 "Time Table Hdr List-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    11-05-2019    CheckStudentBatch                   Function for Check Student Batch.
    // 2         CSPL-00092    11-05-2019    Release All - OnAction              Release All Document
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Time Table List';
    // CardPageID = "Time Tbl Hdr-CS";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Class Time Table Header-CS";
    SourceTableView = sorting("No.") order(descending);
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                Field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                Field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }

                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Template Code"; Rec."Template Code")
                {
                    ApplicationArea = All;
                }
                field("Template Name"; Rec."Template Name")
                {
                    ApplicationArea = All;
                }

                field("Time Table Status"; Rec."Time Table Status")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Release All")
            {
                Image = ReleaseShipment;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //Code added for Release All Document::CSPL-00092::11-05-2019: Start
                    IF CONFIRM(Text_10001Lbl, FALSE) THEN BEGIN
                        TestStudentBatch();
                        ClassTimeTableHeaderCS.Reset();
                        ClassTimeTableHeaderCS.SETRANGE("Time Table Status", ClassTimeTableHeaderCS."Time Table Status"::Open);
                        IF ClassTimeTableHeaderCS.FINDSET() THEN
                            ClassTimeTableHeaderCS.MODIFYALL("Time Table Status", ClassTimeTableHeaderCS."Time Table Status"::Released);
                    END;
                    //Code added for Release All Document::CSPL-00092::11-05-2019: End
                end;
            }
            /* action("Synchronization")
             {


                 ApplicationArea = All;

                 trigger OnAction()
                 begin
                     //CS-SY-1.0 >>
                     //TestGenJournal.InsertEntry(DocumentNo,DocumentType,Accounttype,AccountNo,BalAccountNo,DebitAmount,CreditAmount,StudentRollNo,Transection,PostingDate
                     //,UTRNo,UTRDate,ExternalDocumentNo);
                     //MESSAGE('Done!!');
                     //CS-SY-1.0 <<
                 end;
             }*/

            action("Create Time Table")
            {

                Image = GetLines;
                Promoted = true;
                PromotedOnly = true;
                Visible = false;
                ApplicationArea = All;
                RunObject = Page "Time Table Generation-CS";

            }
        }
    }

    var
        ClassTimeTableHeaderCS: Record "Class Time Table Header-CS";
        StudentMasterCS: Record "Student Master-CS";
        Text_10001Lbl: Label 'Do You Want To Release All Documents ?';


    procedure TestStudentBatch()
    var

        ClassTimeTableLineCS: Record "Class Time Table Line-CS";


        Text_10002Lbl: Label 'Faculty Code Must Have Value In Document No. %1,%2 !!', Comment = '%1 = XML node name ; Rec.%2 = Parent XML node name';
        Text_10003Lbl: Label 'Faculty End Date Must Have Value In Document No. %1 ,%2 !!', Comment = '%1 = XML node name ; Rec.%2 = Parent XML node name';
    begin
        //Code added for Check Student Batch::CSPL-00092::11-05-2019: Start
        ClassTimeTableHeaderCS.Reset();
        IF ClassTimeTableHeaderCS.FINDSET() THEN
            REPEAT
                IF ClassTimeTableHeaderCS."Program" = 'UG' THEN BEGIN
                    IF (ClassTimeTableHeaderCS.Semester = 'I') OR (ClassTimeTableHeaderCS.Semester = 'II') THEN BEGIN
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE(Graduation, Rec."Program");
                        StudentMasterCS.SETRANGE(Semester, Rec.Semester);
                        StudentMasterCS.SETRANGE(Section, Rec.Section);
                        StudentMasterCS.SETRANGE("Academic Year", Rec."Academic Year");
                        StudentMasterCS.SETRANGE(Group, Rec.Group);
                        StudentMasterCS.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                        IF StudentMasterCS.FINDSET() THEN
                            REPEAT
                                IF StudentMasterCS.Batch = '' THEN
                                ERROR(Text_10001Lbl, StudentMasterCS."No.");//CODE COMMENT for warning The number of parameters passed to a string must match the placeholders.
                                                                            // ERROR(Text_10001Lbl);
                            UNTIL StudentMasterCS.NEXT() = 0;

                        ClassTimeTableLineCS.Reset();
                        ClassTimeTableLineCS.SETRANGE("Document No.", ClassTimeTableHeaderCS."No.");
                        IF ClassTimeTableLineCS.FINDSET() THEN
                            REPEAT
                                ClassTimeTableLineCS.TESTFIELD("Subject Code");
                                ClassTimeTableLineCS.TESTFIELD("Room No");
                                ClassTimeTableLineCS.TESTFIELD(Batch);
                                IF ClassTimeTableLineCS."Faculty 1 Code" = '' THEN
                                    ERROR(Text_10002Lbl, ClassTimeTableLineCS."Document No.", ClassTimeTableLineCS."Line No.")
                                ELSE
                                    IF (ClassTimeTableLineCS."Faculty 1 Start Date" <> 0D) AND (ClassTimeTableLineCS."Faculty 1 End Date" = 0D) THEN
                                        ERROR(Text_10003Lbl, ClassTimeTableLineCS."Document No.", ClassTimeTableLineCS."Line No.");
                            UNTIL ClassTimeTableLineCS.NEXT() = 0;

                    END ELSE BEGIN
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE(Graduation, Rec."Program");
                        StudentMasterCS.SETRANGE(Semester, Rec.Semester);
                        StudentMasterCS.SETRANGE(Section, Rec.Section);
                        StudentMasterCS.SETRANGE("Academic Year", Rec."Academic Year");
                        StudentMasterCS.SETRANGE("Course Code", Rec.Course);
                        StudentMasterCS.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                        IF StudentMasterCS.FINDSET() THEN
                            REPEAT
                                IF StudentMasterCS.Batch = '' THEN
                                    ERROR(Text_10001Lbl, StudentMasterCS."No.");//CODE COMMENT for warning The number of parameters passed to a string must match the placeholders.
                                                                                //ERROR(Text_10001Lbl);
                            UNTIL StudentMasterCS.NEXT() = 0;

                        ClassTimeTableLineCS.Reset();
                        ClassTimeTableLineCS.SETRANGE("Document No.", ClassTimeTableHeaderCS."No.");
                        IF ClassTimeTableLineCS.FINDSET() THEN
                            REPEAT
                                ClassTimeTableLineCS.TESTFIELD("Subject Code");
                                ClassTimeTableLineCS.TESTFIELD("Room No");
                                ClassTimeTableLineCS.TESTFIELD(Batch);
                                IF ClassTimeTableLineCS."Faculty 1 Code" = '' THEN
                                    ERROR(Text_10002Lbl, ClassTimeTableLineCS."Document No.", ClassTimeTableLineCS."Line No.")
                                ELSE
                                    IF (ClassTimeTableLineCS."Faculty 1 Start Date" <> 0D) AND (ClassTimeTableLineCS."Faculty 1 End Date" = 0D) THEN
                                        ERROR(Text_10003Lbl, ClassTimeTableLineCS."Document No.", ClassTimeTableLineCS."Line No.");
                            UNTIL ClassTimeTableLineCS.NEXT() = 0;
                    END;

                END ELSE
                    IF ClassTimeTableHeaderCS."Program" = 'PG' THEN BEGIN
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE(Graduation, Rec."Program");
                        StudentMasterCS.SETRANGE("Course Code", Rec.Course);
                        IF ClassTimeTableHeaderCS."Type Of Course" = ClassTimeTableHeaderCS."Type Of Course"::Semester THEN
                            StudentMasterCS.SETRANGE(Semester, Rec.Semester)
                        ELSE
                            StudentMasterCS.SETRANGE(Year, Rec.Year);
                        StudentMasterCS.SETRANGE(Section, Rec.Section);
                        StudentMasterCS.SETRANGE("Academic Year", Rec."Academic Year");
                        StudentMasterCS.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                        IF StudentMasterCS.FINDSET() THEN
                            REPEAT
                                IF StudentMasterCS.Batch = '' THEN
                                    ERROR(Text_10001Lbl, StudentMasterCS."No.");//CODE COMMENT for warning The number of parameters passed to a string must match the placeholders.
                                                                                // ERROR(Text_10001Lbl);
                            UNTIL StudentMasterCS.NEXT() = 0;

                        ClassTimeTableLineCS.Reset();
                        ClassTimeTableLineCS.SETRANGE("Document No.", ClassTimeTableHeaderCS."No.");
                        IF ClassTimeTableLineCS.FINDSET() THEN
                            REPEAT
                                ClassTimeTableLineCS.TESTFIELD("Subject Code");
                                ClassTimeTableLineCS.TESTFIELD("Room No");
                                ClassTimeTableLineCS.TESTFIELD(Batch);
                                IF ClassTimeTableLineCS."Faculty 1 Code" = '' THEN
                                    ERROR(Text_10002Lbl, ClassTimeTableLineCS."Document No.", ClassTimeTableLineCS."Line No.")
                                ELSE
                                    IF (ClassTimeTableLineCS."Faculty 1 Start Date" <> 0D) AND (ClassTimeTableLineCS."Faculty 1 End Date" = 0D) THEN
                                        ERROR(Text_10003Lbl, ClassTimeTableLineCS."Document No.", ClassTimeTableLineCS."Line No.");
                            UNTIL ClassTimeTableLineCS.NEXT() = 0;
                    END;
            UNTIL ClassTimeTableHeaderCS.NEXT() = 0;
        //Code added for Check Student Batch::CSPL-00092::11-05-2019: Start
    end;
}

