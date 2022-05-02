import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'truncate'
})
export class TruncatePipe implements PipeTransform {
  transform(text: string,
    maxLength: number = 100,
    maxWords: number = 20,
    suffix: string = '...'
  ): string {
    if (text.length <= maxLength + 1) {
      return text;
    }

    const splitted = text.split(" ");
    const totalSpaces = splitted.length - 1;
    const words = this.take(splitted, maxWords, maxLength + totalSpaces);
    return words.join(" ") + suffix;
  }

  take(iterable: Iterable<string>, maxWords: number, maxLength: number): string[] {
    let arr = [];
    let i = 0;
    let length = 0;

    for (const word of iterable) {
      i++;
      if (i > maxWords || length + word.length > maxLength) return arr;
      arr.push(word)
      length += word.length;
    }

    return arr;
  }
}
