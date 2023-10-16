page 50069 "Exam Atnd HdrStud Internal-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                           Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  01-08-19   OnAfterGetRecord()                Code added to hide Semester/Year and for document validation.
    // 02.   CSPL-00174  01-08-19   OnNewRecord()                     Code added to document validation.
    // 03.   CSPL-00174  01-08-19   No. - OnAssistEdit()              Code added to generate No.Series.
    // 04.   CSPL-00174  01-08-19   Course Code - OnValidate()        Code added to hide Semester/Year.
    // 05.   CSPL-00174  01-08-19   <Action1000000016> - OnAction()   Code added to function call.
    // 06.   CSPL-00174  01-08-19   <Action1000000018> - OnAction()   Code added to function call.
    // 07.   CSPL-00174  01-08-19   Released - OnAction()             Code added to modify record.
    // 08.   CSPL-00174  01-08-19   ReOpen - OnAction()               Code added to modify record.
    Caption = 'Exam Atnd HdrStud Internal';
    PageType = Document;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Internal Attendance Header-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = NoChangeAllowed;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        //Code added to generate No.Series::CSPL-00174::010819: Start
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.Update();
                        //Code added to generate No.Series::CSPL-00174::010819: End
                    end;
                }
                field("Exam Type"; Rec."Exam Type")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Code added to hide Semester/Year::CSPL-00174::010819: Start
                        // Rec.EventsOfExaminationCS.CSHideSemesterYear(HideSemester, HideYear, Rec."Type Of Course");
                        //Code added to hide Semester/Year::CSPL-00174::010819: End
                    end;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = HideSemester;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Editable = HideYear;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Class"; Rec."Subject Class")
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Staff Code"; Rec."Staff Code")
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part(LINES; 50070)
            {
                ApplicationArea = All;
                Editable = NoChangeAllowed;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Get_Data)
            {
                Caption = 'GetData';
                action(GetData)
                {
                    Caption = 'GetData';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added to function call::CSPL-00174::010819: Start
                        CallExaminationEventforStudent(Rec);
                        //Code added to hide Semester/Year::CSPL-00174::010819: End
                    end;
                }
                action("Get Attendance Percentage")
                {
                    Caption = 'Get Attendance Percentage';
                    Image = Percentage;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added to function call::CSPL-00174::010819: Start
                        CallExaminationEventforStudentPercentage(Rec);
                        //Code added to hide Semester/Year::CSPL-00174::010819: End
                    end;
                }
            }
            group(Approve)
            {
                Caption = 'Approve';
                action(Released)
                {
                    Caption = 'Released';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added to modify record::CSPL-00174::010819: Start
                        Rec.OnReleaseLineExists();
                        InternalAttendanceLineCS.RESET();
                        InternalAttendanceLineCS.SETRANGE("Document No.", Rec."No.");
                        IF InternalAttendanceLineCS.FINDSET() THEN BEGIN
                            InternalAttendanceLineCS.TESTFIELD("Attendance %");
                            RoomAllotedLineCS.RESET();
                            RoomAllotedLineCS.SETRANGE("Document No.", Rec."Room No.");
                            RoomAllotedLineCS.SETRANGE("Line No.", Rec."Room Line No");
                            IF RoomAllotedLineCS.FINDFIRST() THEN BEGIN
                                IF RoomAllotedLineCS."Room Alloted" THEN
                                    ERROR(Text_10002Lbl, Rec."Room No.");
                                IF InternalAttendanceLineCS.COUNT() > RoomAllotedLineCS."Student Capacity" THEN
                                    ERROR(Text_10001Lbl, RoomAllotedLineCS."Student Capacity", REc."No.")
                                ELSE BEGIN
                                    RoomAllotedLineCS."Room Alloted" := TRUE;
                                    RoomAllotedLineCS."Whom Alloted" := Rec."No.";
                                    RoomAllotedLineCS.Modify();
                                END;
                            END;
                            REPEAT
                                InternalAttendanceLineCS.TESTFIELD("Attendance Type");
                                InternalAttendanceLineCS."Room Alloted No." := Rec."Room No.";
                                InternalAttendanceLineCS.Status := InternalAttendanceLineCS.Status::Released;
                                InternalAttendanceLineCS.Modify();
                            UNTIL InternalAttendanceLineCS.NEXT() = 0;
                        END;
                        Rec.Status := Rec.Status::Released;
                        // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Status, NoChangeAllowed);
                        Rec.Modify();
                        CurrPage.UPDATE(FALSE);
                        //Code added to modify record::CSPL-00174::010819: End
                    end;
                }
                action(ReOpen)
                {
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added to modify record::CSPL-00174::010819: Start
                        RoomAllotedLineCS.RESET();
                        RoomAllotedLineCS.SETRANGE("Document No.", Rec."Room No.");
                        RoomAllotedLineCS.SETRANGE("Line No.", Rec."Room Line No");
                        IF RoomAllotedLineCS.FINDFIRST() THEN BEGIN
                            RoomAllotedLineCS."Room Alloted" := FALSE;
                            RoomAllotedLineCS."Whom Alloted" := '';
                            RoomAllotedLineCS.Modify();
                        END;
                        Rec.Status := Rec.Status::Open;
                        // EventsOfExaminationCS.CSOnReopenOfStudentInternalExamAttendanceHeader(Rec);
                        // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Status, NoChangeAllowed);
                        Rec.Modify();
                        CurrPage.UPDATE(FALSE);
                        //Code added to modify record::CSPL-00174::010819: End
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Code added to hide Semester/Year and for document validation::CSPL-00174::010819: Start
        // EventsOfExaminationCS.CSHideSemesterYear(HideSemester, HideYear, "Type Of Course");
        // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Status, NoChangeAllowed);
        //Code added to hide Semester/Year and for document validation::CSPL-00174::010819: End
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Code added to document validation::CSPL-00174::010819: Start
        // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Status, NoChangeAllowed);
        Rec."Exam Type" := Rec."Exam Type"::Regular;
        //Code added to document validation::CSPL-00174::010819: End
    end;

    var

        InternalAttendanceLineCS: Record "Internal Attendance Line-CS";
        RoomAllotedLineCS: Record "Room Alloted Line-CS";
        // EventsOfExaminationCS: Codeunit "Events Of Examination-CS";
        HideYear: Boolean;
        HideSemester: Boolean;
        NoChangeAllowed: Boolean;
        Text_10001Lbl: Label 'The No. of students must be equal to room capaicity i.e. %1 in Document No. %2.';
        Text_10002Lbl: Label 'The Room No. %1 is already alloted. select a different room.';


    [IntegrationEvent(false, false)]
    procedure CallExaminationEventforStudent(InternalAttendanceHeaderCS: Record "Internal Attendance Header-CS")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure CallExaminationEventforStudentPercentage(InternalAttendanceHeaderCS: Record "Internal Attendance Header-CS")
    begin
    end;
}