page 50490 "Non-Affiliated Site Aprvl Card"
{
    Caption = 'Non-Affiliated Site Approval Card';
    PageType = Card;
    SourceTable = "Non-Affiliated Hospital";
    UsageCategory = None;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the No. of Elective Rotation in Non-Affiliated Site Application.';
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Date of Application.';
                    Editable = false;
                }
                group("Student Information")
                {
                    field("Student No."; Rec."Student No.")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the ID of the Student.';
                        Style = Strong;
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("Enrollment No."; Rec."Enrollment No.")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Enrollment No. of the Student.';
                        Style = Strong;
                        Editable = false;
                    }
                    field("Student Name"; Rec."Student Name")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Name of the Student.';
                        Style = Strong;
                        Editable = false;
                    }
                    field("Academic Year"; Rec."Academic Year")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Academic Year of the Student.';
                        Style = Strong;
                        Editable = false;
                    }
                    field(Semester; Rec.Semester)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Semester of the Student.';
                        Style = Strong;
                        Editable = false;
                    }
                }
                group("Hospital Information")
                {
                    field("Name"; Rec."Name")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Name.';
                        ShowMandatory = true;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Address"; Rec."Address")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Address.';
                        MultiLine = true;
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Address 2.';
                        MultiLine = true;
                        Editable = false;
                    }
                    field("City"; Rec."City")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the City.';
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Post Code.';
                        Editable = false;
                    }

                    field("Phone No."; Rec."Phone No.")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Phone No..';
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("Country/Region Code"; Rec."Country/Region Code")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Country/Region Code.';
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the E-mail of Hospital.';
                        ShowMandatory = true;
                        Editable = false;
                    }
                    group("Contact Details")
                    {
                        field("Contact Title"; Rec."Contact Title")
                        {
                            Caption = 'Title';
                            ApplicationArea = All;
                            Tooltip = 'Specifies the Title of Contact Person.';
                            ShowMandatory = true;
                            Editable = false;
                        }
                        field("Contact"; Rec."Contact")
                        {
                            ApplicationArea = All;
                            Tooltip = 'Specifies the Contact Person.';
                            ShowMandatory = true;
                            Editable = false;
                        }
                        field("Contact Phone No."; Rec."Contact Phone No.")
                        {
                            Caption = 'Phone No.';
                            ApplicationArea = All;
                            Tooltip = 'Specifies the Phone No. of the Contact Person.';
                            ShowMandatory = true;
                            Editable = false;
                        }
                        field("Contact E-Mail"; Rec."Contact E-Mail")
                        {
                            Caption = 'E-Mail';
                            ApplicationArea = All;
                            Tooltip = 'Specifies the E-Mail of the Contact Person.';
                            ShowMandatory = true;
                            Editable = false;
                        }
                    }
                    field("ACGME No."; Rec."ACGME No.")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the ACGME #.';
                        Editable = false;
                    }
                    field("Residency"; Rec."Residency")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Residency.';
                        Editable = false;
                    }
                    field("Accreditation"; Rec."Accreditation")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Accreditation.';
                        Editable = false;
                    }
                    field("Sponsoring Institution"; Rec."Sponsoring Institution")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Sponsoring Institution.';
                        Editable = false;
                    }
                    field("Sponsored Programs"; Rec."Sponsored Programs")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Sponsored Programs.';
                        Editable = false;
                    }
                    field("Program ID"; Rec."Program ID")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Program ID.';
                        Editable = false;
                    }
                    field("DME Name"; Rec."DME Name")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the DME Name.';
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("DME Phone No."; Rec."DME Phone No.")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the DME Phone No..';
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("DME Email"; Rec."DME Email")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the DME Email.';
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("Supervising Physician Name"; Rec."Supervising Physician Name")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Supervising Physician Name.';
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("Superviser Phone No."; Rec."Superviser Phone No.")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Superviser Phone No..';
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("Superviser Email"; Rec."Superviser Email")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Superviser Email.';
                        ShowMandatory = true;
                        Editable = false;
                    }
                }


                group("Rotation Course Information")
                {
                    field("Course Code"; Rec."Course Code")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Course for the Rotation.';
                        Style = Unfavorable;
                        ShowMandatory = true;
                        Visible = false;
                        Editable = false;
                    }
                    field("Course Description"; Rec."Course Description")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Course for the Rotation.';
                        Editable = false;
                        Style = Unfavorable;
                        Visible = false;
                    }
                    field("Course Prefix"; Rec."Course Prefix")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Prefix of Subject for the Rotation.';
                        Style = Unfavorable;
                        Visible = false;
                        Editable = false;
                    }
                    field("Elective Course Code"; Rec."Elective Course Code")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Course of Elective Rotation.';
                        Style = Unfavorable;
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("Rotation Description"; Rec."Rotation Description")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Course of Elective Rotation.';
                        Editable = false;
                        Style = Unfavorable;
                    }
                    field("Start Date"; Rec."Start Date")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Start Date of Rotation.';
                        Style = Unfavorable;
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("No. of Weeks"; Rec."No. of Weeks")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the No. of Week(s) of Rotation.';
                        Style = Unfavorable;
                        Editable = false;
                    }
                    field("End Date"; Rec."End Date")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the End Date of Rotation.';
                        Style = Unfavorable;
                        Editable = false;
                    }
                }

                field("Confirmed"; Rec."Confirmed")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Confirmed.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Status of Application';
                    Editable = false;
                }
                field("Reject Reason Code"; Rec."Reject Reason Code")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Reason of Rejection.';
                    Caption = 'Reject Reason Code';
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Reason Description of Rejection.';
                    Caption = 'Reject Reason';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Approve")
            {
                Caption = 'Approve';
                ShortcutKey = 'Ctrl+D';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Vendor: Record Vendor;
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    Rec.TestField(Name);
                    Rec.TestField(Address);
                    Rec.TestField("Student No.");
                    Rec.TestField(City);
                    Rec.TestField("Phone No.");
                    Rec.TestField("E-Mail");

                    if Confirm('Do you want to Approve the Non-Affilated Hospital Elective Rotation?', true) then begin
                        Vendor.Init();
                        Vendor."No." := '';
                        Vendor.Insert(true);
                        Vendor.Name := Rec.Name;
                        Vendor."Name 2" := Rec."Name 2";
                        Vendor."Search Name" := Rec."Search Name";
                        Vendor.Address := Rec.Address;
                        Vendor."Address 2" := Rec."Address 2";
                        Vendor.City := Rec.City;
                        Vendor."Post Code" := Rec."Post Code";
                        Vendor."Country/Region Code" := Rec."Country/Region Code";
                        Vendor.Contact := Rec.Contact;
                        Vendor."E-Mail" := Rec."E-Mail";
                        Vendor."Phone No." := Rec."Phone No.";
                        Vendor."Telex No." := Rec."Telex No.";
                        Vendor."ACGME No." := Rec."ACGME No.";
                        Vendor.Residency := Rec.Residency;
                        Vendor."Sponsoring Institution" := Rec."Sponsoring Institution";
                        Vendor."Sponsored Programs" := Rec."Sponsored Programs";
                        Vendor."DME Name" := Rec."DME Name";
                        Vendor."DME Phone No." := Rec."DME Phone No.";
                        Vendor."DME Email" := Rec."DME Email";
                        Vendor."Supervising Physician Name" := Rec."Supervising Physician Name";
                        Vendor."Superviser Phone No." := Rec."Superviser Phone No.";
                        Vendor."Superviser Email" := Rec."Superviser Email";
                        Vendor."System Ref. No." := Rec."Application No.";
                        Vendor."Vendor Sub Type" := Vendor."Vendor Sub Type"::Hospital;
                        Vendor."Non-Affiliated Hospital" := true;
                        Vendor."LCME Sponsored" := true;
                        Vendor."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                        Vendor.Modify(true);

                        Rec.Validate("System Ref. No.", Vendor."No.");
                        Rec.Validate(Status, Rec.Status::Approved);
                        Rec.Modify();
                        CALE.InsertLogEntry(9, 2, Rec."Student No.", Rec."Student Name", Rec."Application No.", '', '', Rec."Elective Course Code", Rec."Rotation Description");
                        Message('Non-Affiliated Hospital %1 created successfully, for the Non-Affiliated Hospital Application %2.', Vendor."No.", Rec."Application No.");
                        CurrPage.Close();
                    end;
                end;
            }
            action("In-Review")
            {
                ShortcutKey = 'Ctrl+V';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Reject;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if Confirm('Do you want to put the Non-Affilated Hospital application In-Review?') then begin
                        Rec.Validate(Status, Rec.Status::"In-Review");
                        Rec.Modify();
                        CALE.InsertLogEntry(9, 5, Rec."Student No.", Rec."Student Name", Rec."Application No.", Rec."Reject Reason Code", Rec."Reject Reason", Rec."Elective Course Code", Rec."Rotation Description");
                        Message('Non-Affilated Hospital Application %1 of Student No. %2 (%3) is now In-Review.', Rec."Application No.", Rec."Student No.", Rec."Student Name");
                    end;
                end;
            }
            action(Reject)
            {
                ShortcutKey = 'Ctrl+R';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Reject;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if Confirm('Do you want to reject the Non-Affilated Hospital application?') then begin
                        Rec.TestField("Reject Reason Code");
                        Rec.TestField("Reject Reason");
                        Rec.Validate(Status, Rec.Status::Rejected);
                        Rec.Modify();
                        CALE.InsertLogEntry(9, 5, Rec."Student No.", Rec."Student Name", Rec."Application No.", Rec."Reject Reason Code", Rec."Reject Reason", Rec."Elective Course Code", Rec."Rotation Description");
                        Message('Non-Affilated Hospital Application %1 of Student No. %2 (%3) has been rejected.', Rec."Application No.", Rec."Student No.", Rec."Student Name");
                    end;
                end;
            }
        }
    }
}