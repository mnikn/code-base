export class StringUtils {
    public static getFirstSpaceCount(str: string): number {
        let i = 0;
        let firstSpaceCount = 0;
        while (i < str.length && str[i++] === ' ') {
            ++firstSpaceCount;
        }
        return firstSpaceCount;
    }
}
