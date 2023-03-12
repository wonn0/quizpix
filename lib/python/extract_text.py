import sys
import docx2txt

docx_path = sys.argv[1]

text = docx2txt.process(docx_path)

print(text)

# import sys
# import os
# import io
# import re
# import docx
# import PyPDF2

# # Read the file path from command line arguments
# file_path = sys.argv[1]

# # Check if the file exists
# if not os.path.isfile(file_path):
#     print(f"File not found: {file_path}")
#     sys.exit(1)

# # Extract text from the file
# text = ""
# if file_path.endswith(".pdf"):
#     with open(file_path, "rb") as f:
#         pdf_reader = PyPDF2.PdfFileReader(f)
#         for page in pdf_reader.pages:
#             text += page.extract_text()
# elif file_path.endswith(".docx"):
#     doc = docx.Document(file_path)
#     for para in doc.paragraphs:
#         text += para.text
# else:
#     print("Unsupported file format")
#     sys.exit(1)

# # Print the extracted text
# print("Printed text from extract_text.py {text}")
