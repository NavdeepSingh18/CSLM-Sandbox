page 50492 "Non-Affiliated Site Aprvd CRD"
{
    Caption = 'Confirmed Non-Affiliated Application';
    PageType = Card;
    SourceTable = "Non-Affiliated Hospital";
    UsageCategory = None;
    Editable = false;
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
                        ShowMandatory = true;
                    }
                    field("DME Phone No."; Rec."DME Phone No.")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the DME Phone No..';
                        ShowMandatory = true;
                    }
                    field("DME Email"; Rec."DME Email")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the DME Email.';
                        ShowMandatory = true;
                    }
                    field("Supervising Physician Name"; Rec."Supervising Physician Name")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Supervising Physician Name.';
                        ShowMandatory = true;
                    }
                    field("Superviser Phone No."; Rec."Superviser Phone No.")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Superviser Phone No..';
                        ShowMandatory = true;
                    }
                    field("Superviser Email"; Rec."Superviser Email")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Superviser Email.';
                        ShowMandatory = true;
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
                    }
                    field("Course Description"; Rec."Course Description")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Course for the Rotation.';
                        Editable = false;
                        Style = Unfavorable;
                    }
                    field("Course Prefix"; Rec."Course Prefix")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Specifies the Prefix of Subject for the Rotation.';
                        Editable = false;
                        Style = Unfavorable;
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                    Style = Strong;
                }
                field("System Ref. No."; Rec."System Ref. No.")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Affilated Hospital No. if Exist.';
                    Caption = 'Hospital No.';
                    Editable = false;
                    Style = Strong;
                }
                field("Rotation Status"; Rec."Rotation Status")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Status of Rotation.';
                    Caption = 'Rotation Status';
                    Editable = false;
                }
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    Tooltip = 'Specifies the Rotation ID.';
                    Caption = 'Rotation ID';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Hospital Card")
            {
                ShortcutKey = 'Ctrl+D';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Card;
                ApplicationArea = All;

                // trigger OnAction()
                // var
                //     Vendor: Record Vendor;
                //     HospitalCard: page "Hospital Card";
                // begin
                //     if Rec."System Ref. No." = '' then
                //         Error('Affiliated Hospital not found for the No. %1 (%2).', Rec."Application No.", Rec.Name);

                //     Vendor.Reset();
                //     Vendor.FilterGroup(2);
                //     Vendor.SetRange("No.", Rec."System Ref. No.");
                //     Vendor.FilterGroup(0);
                //     HospitalCard.SetTableView(Vendor);
                //     HospitalCard.Editable(false);
                //     HospitalCard.RunModal();
                // end;
            }
        }
    }
}