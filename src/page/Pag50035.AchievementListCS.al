page 50035 "Achievement List-CS"
{
    // version V.001-CS

    // Sr.No  Emp.Id      Date      Trigger                           Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  06-05-19   Open Attachment - OnAction()     Code added for attachment open.
    // 02.   CSPL-00174  06-05-19   Import Document - OnAction()     Code added for import document.
    // 03.   CSPL-00174  06-05-19   Export Attachment - OnAction()   Code added for export attachment.
    // 04.   CSPL-00174  06-05-19   Remove Attachment - OnAction()   Code added for remove attachment.

    AutoSplitKey = true;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Student Achievement-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                }
                field(Enrollment; Rec.Enrollment)
                {
                    ApplicationArea = All;
                }
                field("Roll No"; Rec."Roll No")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Updated By"; Rec."Updated By")
                {
                    ApplicationArea = All;
                }
                field("Updated Date"; Rec."Updated Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Open Attachment")
                {
                    Caption = 'Open Attachment';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for attachment open::CSPL-00174::060519: Start
                        // OpenAttachment();
                        //Code added for attachment open::CSPL-00174::060519: End
                    end;
                }
                action("Import Document")
                {
                    Caption = 'Import Document';
                    Image = Import;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;

                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for import document::CSPL-00174::060519: Start
                        // ImportAttachment();
                        //Code added for import document::CSPL-00174::060519: End
                    end;
                }
                action("Export Attachment")
                {
                    Caption = 'Export Attachment';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for export attachment::CSPL-00174::060519: Start
                        // ExportAttachment();
                        //Code added for export attachment::CSPL-00174::060519: End
                    end;
                }
                action("Remove Attachment")
                {
                    Caption = 'Remove Attachment';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for remove attachment::CSPL-00174::060519: Start
                        // RemoveAttachment(TRUE);
                        //Code added for remove attachment::CSPL-00174::060519: End
                    end;
                }
            }
        }
    }
}