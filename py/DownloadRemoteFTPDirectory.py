import os
from ftplib import FTP
from datetime import datetime

def download_remote_ftp_dir(ftp: FTP, remote_dir, local_dir):

	if not os.path.exists(local_dir):
		os.makedirs(local_dir)

	#Change to working directory
	ftp.cwd(remote_dir)

	#Getting items in the working directory
	items = ftp.nlst()
	#changes for each file downloaded
	downloaded_bytes = 0
	total_bytes = 0

	def progress_callback(data):
		nonlocal downloaded_bytes
		downloaded_bytes += len(data)

		# Display progress
		progress = (downloaded_bytes / total_bytes) * 100
		print(f"\rProgress: {progress:.2f}%", end="")  # Overwrite the line with progress

		local_file.write(data)

	for item in items:
		try:
			#try entering the item if it's a directory
			ftp.cwd(item)
			print(f"Entering directory......{item}")
			download_remote_ftp_dir(ftp, f"{remote_dir}/{item}", os.path.join(local_dir, item))
			ftp.cwd("..")
		except Exception as e:
			total_bytes = ftp.size(item)

			if os.path.exists(f"{local_dir}/{item}") and os.path.getsize(f"{local_dir}/{item}") == total_bytes:
				print(f"Dir {local_dir}/{item} already exists.")
			else:
				local_file_path = os.path.join(local_dir, item)
				print(f"Downloading file: {item} to {local_file_path}")

				downloaded_bytes = 0
				# Download the file
				with open(local_file_path, 'wb') as local_file:
					ftp.retrbinary(f"RETR {item}", progress_callback)
					print("\nDownload complete.")

#host and directory
print("Enter Remote Host:")
remote_host = str(input())

#Connect to host and directory
ftp = FTP(remote_host)
ftp.login()

print ("Enter Remote Directory:")
remote_dir = str(input())
print("Enter Local Download Directory:")
local_dir = str(input())

print('Starting download...')
start = datetime.now()

try:
	download_remote_ftp_dir(ftp, remote_dir, local_dir)
except Exception as e:
	print(f"\nError downloading directory files\n {e}")
finally:
	ftp.quit()

end = datetime.now()
diff = end - start
print('Download took ' + str(diff.seconds) + 's')