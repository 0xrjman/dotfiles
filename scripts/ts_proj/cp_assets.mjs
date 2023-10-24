import fs from 'fs-extra';
import path from 'path';

// Define source and destination directories
const srcDir = 'src';
const destDir = 'dist/src';

// Get all resource files in the source directory
const findResources = (dir) => {
  const resources = [];
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);
    if (stat.isFile() && /\.(svg|png|jpg|mp4)$/i.test(file)) {
      resources.push(filePath);
    } else if (stat.isDirectory()) {
      resources.push(...findResources(filePath));
    }
  }
  return resources;
};

// Copy resource files to the destination directory
const resources = findResources(srcDir);
for (const srcFile of resources) {
  const relPath = path.relative(srcDir, srcFile);
  const destFile = path.join(destDir, relPath);

  fs.ensureDirSync(path.dirname(destFile));
  fs.copyFileSync(srcFile, destFile);

  console.log(`Copied file: ${srcFile} to ${destFile}`);
}

console.log('Copy completed');
