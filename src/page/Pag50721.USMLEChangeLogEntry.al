page 50721 "USMLE Change Log Entry List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DelayedInsert = false;
    SourceTable = "USMLE Log Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Log Entry No."; Rec."Log Entry No.")
                {
                    ApplicationArea = All;

                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                }
                field(USMLEStepNumber; Rec.USMLEStepNumber)
                {
                    ApplicationArea = All;
                }
                field(UsmleID; Rec.UsmleID)
                {
                    ApplicationArea = All;
                }
                field(USMLESentDate; Rec.USMLESentDate)
                {
                    ApplicationArea = All;
                }
                field(USMLEExtended; Rec.USMLEExtended)
                {
                    ApplicationArea = All;
                }
                field("USMLE Consent Release Date"; Rec."USMLE Consent Release Date")
                {
                    ApplicationArea = All;
                }
                field("Transcript Recrd"; Rec."Transcript Recrd")
                {
                    ApplicationArea = All;
                }
                field(AAMICD; Rec.AAMICD)
                {
                    ApplicationArea = All;
                }
                field("Certification Date"; Rec."Certification Date")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Delete Rec"; Rec."Delete Rec")
                {
                    ApplicationArea = All;
                }
                field("Modify Rec"; Rec."Modify Rec")
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Step Att. Ext."; Rec."Step Att. Ext.")
                {
                    ApplicationArea = All;
                }
                field(USMLEAttempt; Rec.USMLEAttempt)
                {
                    ApplicationArea = All;
                }
                field(USMLECancle; Rec.USMLECancle)
                {
                    ApplicationArea = All;
                }
                field(USMLEExtention; Rec.USMLEExtention)
                {
                    ApplicationArea = All;
                }
                field(USMLEOrigin; Rec.USMLEOrigin)
                {
                    ApplicationArea = All;
                }
                field(USMLETestDate; Rec.USMLETestDate)
                {
                    ApplicationArea = All;
                }
                field(USMLETestWindow; Rec.USMLETestWindow)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

}