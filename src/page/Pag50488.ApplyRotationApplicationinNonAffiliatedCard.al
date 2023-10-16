page 50488 "Non-Affiliated Site Card"
{
    Caption = 'Non-Affiliated Site Application Card';
    PageType = Card;
    SourceTable = "Non-Affiliated Hospital";
    UsageCategory = None;

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
                    }
                    field("Address"; Rec."Address")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Address.';
                        MultiLine = true;
                        ShowMandatory = true;
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Address 2.';
                        MultiLine = true;
                    }
                    field("City"; Rec."City")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the City.';
                        ShowMandatory = true;
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Post Code.';
                    }

                    field("Phone No."; Rec."Phone No.")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Phone No..';
                        ShowMandatory = true;
                    }
                    field("Country/Region Code"; Rec."Country/Region Code")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Country/Region Code.';
                        ShowMandatory = true;
                    }
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the E-mail of Hospital.';
                        ShowMandatory = true;
                    }
                    group("Contact Details")
                    {
                        field("Contact Title"; Rec."Contact Title")
                        {
                            Caption = 'Title';
                            ApplicationArea = All;
                            Tooltip = 'Specifies the Title of Contact Person.';
                            ShowMandatory = true;
                        }
                        field("Contact"; Rec."Contact")
                        {
                            Caption = 'Name';
                            ApplicationArea = All;
                            Tooltip = 'Specifies the Contact Person.';
                            ShowMandatory = true;
                        }
                        field("Contact Phone No."; Rec."Contact Phone No.")
                        {
                            Caption = 'Phone No.';
                            ApplicationArea = All;
                            Tooltip = 'Specifies the Phone No. of the Contact Person.';
                            ShowMandatory = true;
                        }
                        field("Contact E-Mail"; Rec."Contact E-Mail")
                        {
                            Caption = 'E-Mail';
                            ApplicationArea = All;
                            Tooltip = 'Specifies the E-Mail of the Contact Person.';
                            ShowMandatory = true;
                        }
                    }
                    field("ACGME No."; Rec."ACGME No.")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the ACGME #.';
                    }
                    field("Residency"; Rec."Residency")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Residency.';
                    }
                    field("Accreditation"; Rec."Accreditation")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Accreditation.';
                    }
                    field("Sponsoring Institution"; Rec."Sponsoring Institution")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Sponsoring Institution.';
                    }
                    field("Sponsored Programs"; Rec."Sponsored Programs")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Sponsored Programs.';
                    }
                    field("Program ID"; Rec."Program ID")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Program ID.';
                    }
                    field("DME Name"; Rec."DME Name")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the DME Name.';
                    }
                    field("DME Phone No."; Rec."DME Phone No.")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the DME Phone No..';
                    }
                    field("DME Email"; Rec."DME Email")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the DME Email.';
                    }
                    field("Supervising Physician Name"; Rec."Supervising Physician Name")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Supervising Physician Name.';
                    }
                    field("Superviser Phone No."; Rec."Superviser Phone No.")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Superviser Phone No..';
                    }
                    field("Superviser Email"; Rec."Superviser Email")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Superviser Email.';
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
                    }
                    field("Course Description"; Rec."Course Description")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Subject for the Rotation.';
                        Editable = false;
                        Style = Unfavorable;
                        Visible = false;
                    }
                    field("Course Prefix"; Rec."Course Prefix")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Prefix of Course for the Rotation.';
                        Style = Unfavorable;
                        Visible = false;
                    }
                    field("Elective Course Code"; Rec."Elective Course Code")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Course of Elective Rotation.';
                        Style = Unfavorable;
                        ShowMandatory = true;
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
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Status of Application';
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
                ShortcutKey = 'Ctrl+F9';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Confirm;
                ApplicationArea = All;
                Enabled = EditAllow;

                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    Rec.TestField("Student No.");
                    Rec.TestField(Name);
                    Rec.TestField(Address);
                    Rec.TestField(City);
                    Rec.TestField("Country/Region Code");
                    Rec.TestField("Phone No.");
                    Rec.TestField("Elective Course Code");
                    Rec.TestField("Start Date");


                    if Confirm('Do you want to continue?') then begin
                        Rec.Validate(Confirmed, true);
                        Rec.Validate(Rec.Status, Rec.Status::"Pending for Approval");
                        CALE.InsertLogEntry(9, 1, Rec."Student No.", Rec."Student Name", Rec."Application No.", '', '', Rec."Elective Course Code", Rec."Rotation Description");
                        Rec.Modify();
                        EditAllow := not Rec.Confirmed;
                        CurrPage.Editable(EditAllow);
                        Message('Non-Affilated Hospital Application confirmed Successfully.');
                        CurrPage.Close();
                    end;
                end;
            }
        }
    }

    var
        EditAllow: Boolean;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        if not UserSetup.Get(UserId) then
            Error('User Setup not found for the UserID %1.', UserId);

        Rec."Global Dimension 1 Code" := '9000';
        GetClerkshipSemesterFilter();
        EditAllow := true;
    end;

    trigger OnAfterGetRecord()
    begin
        GetClerkshipSemesterFilter();
        EditAllow := not Rec.Confirmed;
        CurrPage.Editable(EditAllow);

        CurrPage.Update(true);
    end;

    procedure GetClerkshipSemesterFilter()
    var
        EducationSetup: Record "Education Setup-CS";
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        if EducationSetup.FindFirst() then
            EducationSetup.TestField("Elective Semester Filter");

        Rec.SetFilter("Clerkship Semester Filter", EducationSetup."Elective Semester Filter");
    end;
}