page 50635 "Clinical Hold Reason Input"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Student Master-CS";

    layout
    {
        area(Content)
        {
            group(General)
            {
                group("Student Details")
                {
                    field("No."; Rec."No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Enrollment No."; Rec."Enrollment No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("First Name"; Rec."First Name")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Middle Name"; Rec."Middle Name")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Last Name"; Rec."Last Name")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Student Name"; Rec."Student Name")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(Semester; Rec.Semester)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Academic Year"; Rec."Academic Year")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Course Code"; Rec."Course Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Spcl Accommodation Appln"; Rec."Spcl Accommodation Appln")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Document Specialist"; Rec."Document Specialist")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("FM1/IM1 Coordinator"; Rec."FM1/IM1 Coordinator")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Clinical Coordinator"; Rec."Clinical Coordinator")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
                group(Reason)
                {
                    field(ReasonCode; ReasonCode)
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        Style = Unfavorable;
                        Caption = 'Reason Code';
                        TableRelation = "Reason Code".Code where(Type = const("Clinical Hold"));

                        trigger OnValidate()
                        var
                            LReasonCode: Record "Reason Code";
                        begin
                            ReasonDescription := '';
                            LReasonCode.Reset();
                            if LReasonCode.Get(ReasonCode) then
                                ReasonDescription := LReasonCode.Description;
                        end;
                    }
                    field(ReasonDescription; ReasonDescription)
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        Style = Unfavorable;
                        MultiLine = true;
                        Caption = 'Reason Description';
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Confirm)
            {
                ApplicationArea = All;
                Image = Confirm;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    LGroup: Record Group;
                    StudentGroup: Record "Student Group";
                    StudentGroupChk: Record "Student Group";
                    StudentHold: Record "Student Hold";
                    StudentWiseHolds: Record "Student Wise Holds";
                    StudentWiseHoldsChk: Record "Student Wise Holds";
                    HoldStatusLedger: Record "Hold Status Ledger";
                    CALE: Record "Clerkship Activity Log Entries";
                    StudentMaster_lRec: REcord "Student Master-CS";
                    ClinicalNotification: Codeunit "Clinical Notification";
                    LastEntryNo: Integer;
                begin
                    if not Confirm('Do you want to set Clinical Hold on Student No. %1 (%2)?', true, Rec."No.", Rec."Student Name") then
                        exit;
                    LGroup.Reset();
                    LGroup.SetRange("Group Type", LGroup."Group Type"::Clinical);
                    if not LGroup.FindFirst() then
                        Error('Student Group not found for Clinical Clerkship.\Please Group Hold Code for Institute Code %1.', Rec."Global Dimension 1 Code");

                    StudentHold.Reset();
                    StudentHold.SetRange("Group Code", LGroup.Code);
                    if not StudentHold.FindFirst() then
                        Error('Student Hold not found for Group %1.', LGroup.Code);

                    StudentMaster_lRec.Reset();
                    StudentMaster_lRec.SetRange("Original Student No.", Rec."Original Student No.");
                    If StudentMaster_lRec.FindSet() then begin
                        repeat
                            StudentGroupChk.Reset();
                            StudentGroupChk.SetRange("Student No.", StudentMaster_lRec."No.");
                            StudentGroupChk.SetRange("Groups Code", LGroup.Code);
                            if not StudentGroupChk.findfirst() then begin
                                StudentGroup.Init();
                                StudentGroup.Validate("Student No.", StudentMaster_lRec."No.");
                                StudentGroup."Academic Year" := StudentMaster_lRec."Academic Year";
                                StudentGroup.Semester := StudentMaster_lRec.Semester;
                                StudentGroup.Term := StudentMaster_lRec.Term;
                                StudentGroup."Groups Code" := LGroup.Code;
                                StudentGroup.Description := LGroup.Description;
                                StudentGroup."Created By" := UserId();
                                StudentGroup."Creation Date" := Today();
                                StudentGroup.Validate("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                                StudentGroup."Group Type" := LGroup."Group Type";
                                StudentGroup.Insert(true);

                                StudentWiseHoldsChk.Reset();
                                StudentWiseHoldsChk.SetRange("Student No.", StudentMaster_lRec."No.");
                                StudentWiseHoldsChk.SetRange("Hold Code", StudentHold."Hold Code");
                                if StudentWiseHoldsChk.FindFirst() then begin
                                    StudentWiseHoldsChk.Status := StudentWiseHoldsChk.Status::Enable;
                                    StudentWiseHoldsChk.Modify(true);
                                end
                                else begin
                                    StudentWiseHolds.Init();
                                    StudentWiseHolds.Validate("Student No.", StudentMaster_lRec."No.");
                                    StudentWiseHolds."Student Name" := StudentMaster_lRec."Student Name";
                                    StudentWiseHolds."Academic Year" := StudentMaster_lRec."Academic Year";
                                    StudentWiseHolds."Admitted Year" := StudentMaster_lRec."Admitted Year";
                                    StudentWiseHolds.Semester := StudentMaster_lRec.Semester;

                                    StudentWiseHolds."Hold Code" := StudentHold."Hold Code";
                                    StudentWiseHolds."Hold Description" := StudentHold."Hold Description";
                                    StudentWiseHolds."Hold Type" := StudentHold."Hold Type";
                                    StudentWiseHolds."Potal Login Restriction" := StudentHold."Potal Login Restriction";
                                    StudentWiseHolds."Clinical Rotation" := StudentHold."Clinical Rotation";
                                    StudentWiseHolds."Transcript Print" := StudentHold."Transcript Print";
                                    StudentWiseHolds.Progression := StudentHold.Progression;
                                    StudentWiseHolds.Billing := StudentHold.Billing;
                                    StudentWiseHolds."Sign-off" := StudentHold."Sign-off";
                                    StudentWiseHolds.Validate("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                                    StudentWiseHolds.Status := StudentWiseHolds.Status::Enable;
                                    StudentWiseHolds.Insert();

                                    HoldStatusLedger.Reset();
                                    if HoldStatusLedger.FINDLAST() then
                                        LastEntryNo := HoldStatusLedger."Entry No." + 1
                                    else
                                        LastEntryNo := 1;

                                    HoldStatusLedger.Init();
                                    HoldStatusLedger."Entry No." := LastEntryNo;
                                    HoldStatusLedger."Student No." := StudentMaster_lRec."No.";
                                    HoldStatusLedger."Student Name" := StudentMaster_lRec."Student Name";
                                    HoldStatusLedger."Academic Year" := StudentMaster_lRec."Academic Year";
                                    HoldStatusLedger."Admitted Year" := StudentMaster_lRec."Admitted Year";
                                    HoldStatusLedger.Semester := StudentMaster_lRec.Semester;
                                    HoldStatusLedger."Entry Date" := Today();
                                    HoldStatusLedger."Entry Time" := Time();
                                    HoldStatusLedger."Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                                    HoldStatusLedger."Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                                    HoldStatusLedger."User ID" := UserId();
                                    HoldStatusLedger."Hold Code" := StudentHold."Hold Code";
                                    HoldStatusLedger."Hold Description" := StudentHold."Hold Description";
                                    HoldStatusLedger."Hold Type" := StudentHold."Hold Type";
                                    HoldStatusLedger.Status := HoldStatusLedger.Status::Enable;
                                    HoldStatusLedger.Insert();
                                end;

                                // ClinicalNotification.ClinicalHOLDNotificationDocumentExpire(StudentMaster_lRec."No.");
                                CALE.InsertLogEntry(11, 11, StudentMaster_lRec."No.", StudentMaster_lRec."Student Name", 'NA', ReasonCode, ReasonDescription, '', '');
                            end;
                        until StudentMaster_lRec.Next() = 0;
                    end;
                    Message('Clinical Hold applied on Student No. %1 (%2).', Rec."No.", Rec."Student Name");
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        ReasonCode: Code[20];
        ReasonDescription: Text[100];
}