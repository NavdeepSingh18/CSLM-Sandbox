page 50411 "Student Picture"
{
    Caption = 'Student Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Student Master-CS";

    layout
    {
        area(content)
        {
            field("Student Image"; Rec."Student Image")
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the picture of the customer, for example, a logo.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            //  action(TakePicture)
            //  {
            //      ApplicationArea = All;
            //      Caption = 'Take';
            //      Image = Camera;
            //      Promoted = true;
            //      PromotedOnly = true;
            //      PromotedCategory = Process;
            //      PromotedIsBig = true;
            //      ToolTip = 'Activate the camera on the device.';
            //      Visible = CameraAvailable;


            //  }
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';
                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                begin
                    Rec.TestField("No.");
                    if Rec."Student Name" = '' then
                        Error(MustSpecifyNameErr);
                    if Rec."Applicant Image".HasValue() then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    // FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        exit;

                    Clear(Rec."Student Image");
                    // Rec."Student Image".Import(FileName);
                    if not Rec.Modify(true) then
                        Rec.Insert(true);

                    // if FileManagement.DeleteServerFile(FileName) then;
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Image = Import;
                ToolTip = 'Delete a picture file.';
                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                begin
                    Rec.TestField("No.");
                    if Rec."Student Name" = '' then
                        Error(MustSpecifyNameErr);
                    if Not Rec."Student Image".HasValue() then
                        exit;
                    Clear(Rec."Student Image");
                    if not Rec.Modify(true) then
                        Rec.Insert(true);
                end;
            }
        }
    }
    var
        MustSpecifyNameErr: Label 'You must specify a Student Name before you can import a picture.';
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        SelectPictureTxt: Label 'Select a picture to upload';

}

