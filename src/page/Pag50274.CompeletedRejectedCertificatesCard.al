page 50274 "Compelete Reject Certificate"
{
    // version V.001-CS

    // Sr.No Emp.ID       Date       Trigger                        Remarks
    // ------------------------------------------------------------ ------------------------------------------------
    // 01.   CSPL-00174   05-04-19   Rejected - OnAction()          Code added for confirmattion message with update status.
    // 02.   CSPL-00174   05-04-19   Approved/Printed - OnAction()  Code added for approval and Printed with mail.

    Caption = 'Completed Rejected Transcript/Degree Request Card';
    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Certificates Application-CS";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    Editable = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field(Certificate; Rec.Certificate)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Application Completed Date"; Rec."Application Completed Date")
                {
                    ApplicationArea = All;
                }

                field("Completed By"; Rec."Completed By")
                {
                    ApplicationArea = All;
                }


                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }



                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;

                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }

                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                }

                field("Organization Name "; Rec."Organization Name ")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Courier Address"; Rec."Courier Address")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }



                field(Remark; Rec.Remark)
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
                    Visible = false;

                }
                field(Statement; Rec.Statement)
                {
                    ApplicationArea = All;
                    Caption = 'Statement';
                    Visible = false;
                }
                field("Mode of Collection"; Rec."Mode of Collection")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                }

                field("Courier Type"; Rec."Courier Type")
                {
                    ApplicationArea = All;
                }
                field("Courier No."; Rec."Courier No.")
                {
                    ApplicationArea = All;
                }
                field("Courier Charges"; Rec."Courier Charges")
                {
                    ApplicationArea = All;
                }
                Field("Payment Status"; Rec."Payment Status")
                {
                    ApplicationArea = All;
                }



                field("Approved or Printed"; Rec."Approved/Printed")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Last Print Date/Time"; Rec."Last Print Date/Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No of Prints"; Rec."No of Prints")
                {
                    ApplicationArea = All;
                    Visible = false;

                }

                field("Rejected On"; Rec."Rejected On")
                {
                    ApplicationArea = All;
                }
                field("Rejected By"; Rec."Rejected By")
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
            action("Student Notes")
            {
                ApplicationArea = All;
                Caption = 'Student Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                    TemplateType: Option " ",Residency,"Clinical Clerkship",Student,Other;
                    GroupType: Option " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other;
                begin
                    Rec.TestField("Student No.");
                    TemplateType := TemplateType::Student;
                    GroupType := GroupType::Student;
                    ClinicalBaseAppSubscribe.ViewEditStudentNote(Rec."Student No.", Rec."Student No.", TemplateType, GroupType);
                end;
            }
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
        }
    }



}